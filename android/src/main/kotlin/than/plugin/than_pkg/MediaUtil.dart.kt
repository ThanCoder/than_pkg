package than.plugin.than_pkg

import android.media.MediaFormat
import android.media.MediaPlayer
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.view.Surface
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.TextureRegistry

object MediaUtil {
    private var mediaPlayer: MediaPlayer? = null
    private var eventSink: EventChannel.EventSink? = null

    private var textureEntry: TextureRegistry.SurfaceTextureEntry? = null
    private var surface: Surface? = null


    fun callCheck(
        call: MethodCall,
        result: MethodChannel.Result,
        textureRegistry: TextureRegistry
    ) {
        // Method name ကို "audioUtil/play" → "play" လို့ extract
        val method = call.method.replace("mediaUtil/", "")

        when (method) {
            "createTexture" -> {
                val id = createTexture(textureRegistry)
                result.success(id)
            }

            "play" -> {
                val path = call.argument<String>("path")
                val isVideo = call.argument<Boolean>("isVideo") ?: false
                if (path != null) {
                    play(path, isVideo)
                    result.success(null)
                } else {
                    result.error("INVALID_PATH", "No path provided", null)
                }
            }

            "duration" -> {
                result.success(mediaPlayer?.duration)
            }

            "currentPosition" -> {
                result.success(mediaPlayer?.currentPosition)
            }


            "stop" -> {
                mediaPlayer?.stop()
                mediaPlayer?.release()
                mediaPlayer = null
                result.success(null)
            }

            "pause" -> {
                if (mediaPlayer?.isPlaying == true) {
                    mediaPlayer?.pause()
                }
                result.success(null)
            }

            "seekTo" -> {
                val msec = call.argument<Int>("msec") ?: 0
                mediaPlayer?.let { mp ->
                    val wasPlaying = mp.isPlaying
                    Handler(Looper.getMainLooper()).post {
                        if (Build.VERSION.SDK_INT >= 26) {
                            mp.seekTo(msec.toLong(), MediaPlayer.SEEK_CLOSEST)
                        } else {
                            mp.seekTo(msec)
                        }
                    }
                }
                result.success(null)
            }

            "resume" -> {
                mediaPlayer?.start()
                result.success(null)
            }

            "release" -> {
                release()
                result.success(null)
            }
//           video
            "videoWidth" -> {
                result.success(mediaPlayer?.videoWidth)
            }

            "videoHeight" -> {
                result.success(mediaPlayer?.videoHeight)
            }

            "setVolume" -> {
                val leftVolume = call.argument<Float>("leftVolume") ?: 0
                val rightVolume: Any = call.argument<Float>("rightVolume") ?: 0
                mediaPlayer?.setVolume(leftVolume as Float, rightVolume as Float)
                result.success(null)
            }

            "isPlaying" -> {
                result.success(mediaPlayer?.isPlaying)
            }

            "trackInfo" -> {
                result.success(getTrackInfoMap())
            }

            else -> result.notImplemented()
        }
    }

    fun play(path: String, isVideo: Boolean = false) {
        mediaPlayer?.release()
        mediaPlayer = MediaPlayer().apply {
            setDataSource(path)
            if (isVideo) {
                setSurface(surface)
            }

            setOnPreparedListener {
                start()
                // duration event ပို့
                eventSink?.success(mapOf("event" to "prepared", "duration" to duration))
            }
            setOnBufferingUpdateListener { _, percent ->
                // buffering percent ပို့
                eventSink?.success(
                    mapOf(
                        "event" to "buffering",
                        "percent" to percent,
                        "duration" to duration,
                        "currentPosition" to currentPosition
                    )
                )
            }
            setOnCompletionListener {
                eventSink?.success(mapOf("event" to "completed"))
            }
            prepareAsync()
        }
    }


    fun setEventChannel(eventChannel: EventChannel) {
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }
        })
    }

    /** create for video playback (Texture) */
    fun createTexture(registry: TextureRegistry): Long {
        textureEntry = registry.createSurfaceTexture()
        surface = Surface(textureEntry!!.surfaceTexture())
        return textureEntry!!.id()
    }

    fun release() {
        mediaPlayer?.release()
        mediaPlayer = null
        surface?.release()
        surface = null
        textureEntry?.release()
        textureEntry = null
    }

    fun getTrackInfoMap(): List<Map<String, Any?>> {
        val result = mutableListOf<Map<String, Any?>>()
        mediaPlayer?.trackInfo?.forEachIndexed { index, track ->
            val map = mutableMapOf<String, Any?>()
            map["index"] = index
            map["trackType"] = when (track.trackType) {
                MediaPlayer.TrackInfo.MEDIA_TRACK_TYPE_VIDEO -> "video"
                MediaPlayer.TrackInfo.MEDIA_TRACK_TYPE_AUDIO -> "audio"
                MediaPlayer.TrackInfo.MEDIA_TRACK_TYPE_TIMEDTEXT -> "timedtext"
                MediaPlayer.TrackInfo.MEDIA_TRACK_TYPE_SUBTITLE -> "subtitle"
                else -> "unknown"
            }
            map["language"] = track.language

            if (android.os.Build.VERSION.SDK_INT >= 28) {
                track.format?.let { fmt ->
                    map["mime"] = fmt.getString(MediaFormat.KEY_MIME)
                    if (fmt.containsKey(MediaFormat.KEY_SAMPLE_RATE)) {
                        map["sampleRate"] = fmt.getInteger(MediaFormat.KEY_SAMPLE_RATE)
                    }
                    if (fmt.containsKey(MediaFormat.KEY_CHANNEL_COUNT)) {
                        map["channelCount"] = fmt.getInteger(MediaFormat.KEY_CHANNEL_COUNT)
                    }
                    if (fmt.containsKey(MediaFormat.KEY_WIDTH)) {
                        map["width"] = fmt.getInteger(MediaFormat.KEY_WIDTH)
                    }
                    if (fmt.containsKey(MediaFormat.KEY_HEIGHT)) {
                        map["height"] = fmt.getInteger(MediaFormat.KEY_HEIGHT)
                    }
                }
            }

            result.add(map)
        }
        return result
    }

}
