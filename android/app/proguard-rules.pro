# AGP 9 R8 full mode can strip Room/WorkManager reflective constructors.
# google_mobile_ads → WorkManagerInitializer needs WorkDatabase_Impl.<init>().
# Keep even with work-runtime 2.11.2 forced in build.gradle.kts.
-keep class * extends androidx.room.RoomDatabase {
    <init>();
}
-keep class androidx.work.** {
    <init>(...);
}
