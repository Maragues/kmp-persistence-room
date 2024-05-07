package com.maragues.kmppersistence

import androidx.room.Room
import androidx.room.RoomDatabase
import platform.Foundation.NSHomeDirectory
import com.maragues.kmppersistence.instantiateImpl

fun getDatabaseBuilder(): RoomDatabase.Builder<AppDatabase> {
    val dbFilePath = NSHomeDirectory() + "/my_room.db"
    return Room.databaseBuilder<AppDatabase>(
        name = dbFilePath,
        factory =  { AppDatabase::class.instantiateImpl() }
    )
}
