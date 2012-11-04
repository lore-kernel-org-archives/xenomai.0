MIME-Version: 1.0
In-Reply-To: <50969760.70307@xenomai.org>
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
	<ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>
	<CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>
	<9d3ef55df641c8657ce09c6f6e023e4a.squirrel@www.xenomai.org>
	<CAOiXNkA8u2TjB7FXoJh7opxasgCvnuFkuqOEPZ=tCMz-f-HMpQ@mail.gmail.com>
	<2b4941d6b09c5560d4074bc644ded41d.squirrel@www.xenomai.org>
	<CAOiXNkC=C6A=Mfhqx2rjg61D9UaOB55bnm-n5mOArsmpXdU-sg@mail.gmail.com>
	<50958A57.8010902@xenomai.org>
	<CAOiXNkAQxitHg=uQRhL-+h1vNGRQh-3-JXaOz78NmvwdtqDTdA@mail.gmail.com>
	<50958DD4.1000702@xenomai.org>
	<CAOiXNkANO_1205mweCok_34Z_fQgLFRtg4w4xehNj3X+xOpfQw@mail.gmail.com>
	<50969760.70307@xenomai.org>
Date: Sun, 4 Nov 2012 17:48:46 +0100
Message-ID: <CAOiXNkCsfGArU+XyfYMgv4-TF=aXFqHmhy7BihNfXZUnerjbEw@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] rt_task_create fails when running over ssh
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Did you check if your compiler compiles thumb code or arm code by default?

Here are my compilation options:

ARCH=arm CROSS_COMPILE=arm-angstrom-linux-gnueabi- CFLAGS="
-march=armv7-a -fno-tree-vectorize -mthumb-interwork
-mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8 " LOCALVERSION=""

