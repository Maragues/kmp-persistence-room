package com.maragues.kmppersistence

import io.realm.kotlin.Realm
import io.realm.kotlin.RealmConfiguration
import io.realm.kotlin.types.RealmObject
import io.realm.kotlin.types.annotations.PrimaryKey
import org.mongodb.kbson.ObjectId
import io.realm.kotlin.ext.query

interface Database {
    val movieDao: MovieDao
}

interface MovieDao {
    suspend fun count(): Long
    suspend fun insert(item: MovieEntity)
}

class MovieEntity : RealmObject {
    @PrimaryKey
    var _id: ObjectId = ObjectId()
    var title: String = ""
}

private val config = RealmConfiguration.create(schema = setOf(MovieEntity::class))
internal val realm: Realm = Realm.open(config)

@Suppress("unused")
fun getDatabase(): Database {
    return RealmDatabase(realm = realm)
}

internal class RealmDatabase(realm: Realm) : Database {
    override val movieDao: MovieDao = RealmMovieDao(realm = realm)
}

internal class RealmMovieDao(private val realm: Realm) : MovieDao {
    override suspend fun count(): Long {
        return realm.query<MovieEntity>().count().find()
    }

    override suspend fun insert(item: MovieEntity) {
        realm.writeBlocking {
            copyToRealm(item)
        }
    }
}
