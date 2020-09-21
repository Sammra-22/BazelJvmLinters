package com.sample.lib.ktgenerator

import kotlin.random.Random

object KtIntGenerator {

    @JvmStatic
    fun next(l: Int, h: Int) = Random.nextInt(l, h)
}
