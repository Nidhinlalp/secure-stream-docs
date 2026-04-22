import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.example.secure_stream_docs.dev"
            resValue(type = "string", name = "app_name", value = "Secure Stream Dev")
        }
        create("stage") {
            dimension = "flavor-type"
            applicationId = "com.example.secure_stream_docs.stage"
            resValue(type = "string", name = "app_name", value = "Secure Stream Stage")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.example.secure_stream_docs"
            resValue(type = "string", name = "app_name", value = "Secure Stream")
        }
    }
}