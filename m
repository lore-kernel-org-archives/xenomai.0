MIME-Version: 1.0
Date: Wed, 11 Jul 2012 18:32:03 +0430
Message-ID: <CAKKWdteZWSdH2dywoj6Ro8BTfYmV0HOC6-Gt6jjjVH_UV9VUKg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] questions: system timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

1) How the system clock is set, i mean weather it is
periodic/aperiodic and the period? It is done by the extra code which
is added by Xenomai? or it is done by mainline kernel after boot-up
first time.

2) Can rt_timer_set_mode() set the period to one nano second?!

3) Native-API_Tour manual is not updated. It talks about one variable
CONFIG_XENO_OPT_TIMING_PERIOD which can be 0 or a number.

4) Why each skin has a different period? Which one is used after boot-up?

