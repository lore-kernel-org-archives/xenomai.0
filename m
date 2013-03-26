Date: Tue, 26 Mar 2013 16:13:04 +0100
From: =?utf-8?q?Petr_Cervenka?= <grugh@centrum.cz>
References: <20130312102938.B04FB5F2@centrum.cz> <513F1CF6.8010306@xenomai.org>
In-Reply-To: <513F1CF6.8010306@xenomai.org>
MIME-Version: 1.0
Message-Id: <20130326161304.5A243765@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] =?utf-8?q?mutex_problem?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Gilles_Chanteperdrix?= <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

I have some long term results:
>
>>=20
>> PS: Meanwhile I found another mutex, which was deleted immediately
>> after creation, but commonly used later.
>
>
>Well, yes, that could cause such issues. Could you try setting
>mutex->fastlock to NULL in rt_mutex_delete?
>

Usage of deleted mutex was really the real cause of the error. It influen=
ced other mutex(es) as well.

Setting of the mutex->synch_base.fastlock to NULL in rt_mutex_delete was =
also proper workaround.

Petr

