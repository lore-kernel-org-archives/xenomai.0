Message-ID: <2ff1a98a0708290144i6e25c48dv90c77504874b4d20@domain.hid>
Date: Wed, 29 Aug 2007 10:44:36 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <715959.48066.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <715959.48066.qm@domain.hid>
Subject: Re: [Xenomai-help] sqrt() function in xenomai kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
Cc: xenomai@xenomai.org

On 8/29/07, Mathieu JOINIE-MAURIN <mjoiniem@domain.hid> wrote:
>
> Hi,
>
> I need to use a sqrt() function in a kernel module code. I am a beginner
> with Xenomai. Is there any math_module which already exists ?
>
> Thanks in advance,

There is no math module, if you really want to, you can port the
libmath from a c library such as the glibc or uclibc, or newlib and
make it a kernel module. If you do so, we willl be pleased to add this
module to Xenomai.

Now, regarding the sqrt function, if what you want is the integer
square root of an integer argument, you can use the int_sqrt function,
declared in linux/kernel.h.


-- 
                                               Gilles Chanteperdrix

