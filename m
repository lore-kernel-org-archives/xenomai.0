MIME-Version: 1.0
From: AG M <agm6274@gmail.com>
Date: Sat, 25 Feb 2017 21:57:44 -0600
Message-ID: <CALD0yU7aZc2gMB701Q0i1t_hm=S7i2YbTC_8zcridaDOcPqb1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] 'pthread_create: Operation not permitted' Issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm running Xenomai Cobalt v3.0.4 on 32 bit ARM.

To test whether everything has been installed properly, I ran
/usr/xenomai/bin/latency -t 0 and it throws this error
"pthread_create(latency): Operation not permitted"

Running the same as an in-kernel periodic task
/usr/xenomai/bin/latency -t 0 works.

Couple of things

1. I'm running as a root user
(http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/)
2. The xenomai group on Linux is as follows: xenomai:x:995:debian,root


I ran some sample programs with pthread and its the same issue as the
latency test.

What could be the issue?

Thanks.

