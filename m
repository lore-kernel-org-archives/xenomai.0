MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 20 Sep 2019 15:34:29 +0200
Message-ID: <CAFc1U0sBsAvi3Spz6+9ExCr1gpkB81BTjVC31G84WKyfbwPBmg@mail.gmail.com>
Subject: Problem with _rt / _nrt functions in Xeno 3
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I've been using RTDM _rt / _nrt functions for a long time with Xenomai
2.6.x but it seems not to work (the same way ?) with Xenomai 3 (tested with
several versions up to 3.0.8). Actually the _nrt driver function is never
called (_rt is always called...). I wrote a simple example for Xeno 2 and
Xeno 3 available here:

https://github.com/pficheux/xenomai_examples.git

Here is the test on Raspberry Pi 3 (Xeno 3).

# insmod rtdm_test.ko

# ./xenomai_test

[   47.661245] RTDM open:.

[   47.667473] ioctl: RT

[   47.672674] ioctl: RT

[   48.667479] ioctl: RT

[   48.678078] ioctl: RT

[   49.667463] ioctl: RT

[   49.683076] ioctl: RT

[   50.667463] ioctl: RT

[   50.687868] ioctl: RT


Of course it works fine with Xenomai 2 (on Pi B+) :

# insmod rtdm_test.ko

# ./xenomai_test

[  753.614275] RTDM open

[  753.632852] ioctl: RT

[  753.636779] ioctl: NRT

[  755.632839] ioctl: RT

[  755.640252] ioctl: NRT

[  756.632841] ioctl: RT

[  757.632838] ioctl: RT

[  757.643779] ioctl: NRT

[  758.632836] ioctl: RT

Thx by advance for your help


regards

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
