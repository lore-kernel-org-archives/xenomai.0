Message-ID: <2ff1a98a0801080701l3268cbb2l6382399201741127@domain.hid>
Date: Tue, 8 Jan 2008 16:01:28 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <24653876.1199792394399.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <14854214.1199776626079.JavaMail.ngmail@domain.hid>
	<2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>
	<24653876.1199792394399.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] posix functions for real time and non real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Jan 8, 2008 12:39 PM, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> Hi Gilles,
>
> thank you very much for the response.
> I tried this out and found one strange thing:
> When I run the following simple example (that uses the __real_pthread_ functions)
> the executable appears in the /proc/xenomai/stat list.
> As I am calling __real_pthread_create() I expected that my program does not appear
> in xenomai at all.
> Build is done using xeno-config --posix-cflags plus -O2 -Wall. For linking xeno-config --posix-ldflags
> is used.
>
> Another question:
> Is there a special header file available that has some defines to map the pthread_xxx
> function to __real_pthread_xxx.
> By including this header I do not have to modify the C code of that files that should
> use the non real-time functions.

To answer precisely to this question: I really think that adding such
a header would create a source of confusion. The current scheme is
pretty simple use pthread_* variants for real-time, use
__real_pthread_* for the rare case when you do not need real-time, and
I really wish to keep it as simple as it currently is.

-- 
                                               Gilles Chanteperdrix

