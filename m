MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 1 Mar 2018 18:07:34 +0530
Message-ID: <CAOuPNLiNGpnvWcj_6xZV0FWZfqMgi3Xc61GaHfZP1N58TYFYcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] [NATIVE API] Xenomai native API equivalent for
	clock_gettime
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, Jan Kiszka <jan.kiszka@web.de>, Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>

Hi,

I have one question about Xenomai native API

1) What is the native API equivalent for clock_gettime() ?

I have seen this Xenomai native API guide but I could not find it.
https://xenomai.org/documentation/xenomai-2.6/pdf/native-api.pdf

I have a simple pthread based POSIX application which I converted to native API.
But for calculating the latency difference I using this in both case:
clock_gettime(CLOCK_MONOTONIC, &now);

But I observed that if I use only NATIVE skin, I could not see any
latency difference.
However, if I use POSIX skin I see the latency difference.

So, I want to replace clock_gettime() with native API to find the
exact difference with native skin.

Or, if there is any other better way to measurement latency difference
between POSIX API and native API, please let me know.



Thank You!

Regards,
Pintu

