Message-ID: <51111685.6070107@xenomai.org>
Date: Tue, 05 Feb 2013 15:26:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu>
	<510FFE7C.1090601@xenomai.org>	<51100A6B.90701@icid.cu>
	<5110122C.2090807@xenomai.org>	<511021FC.7080906@icid.cu>
	<51102316.9090107@xenomai.org>	<511027E6.4080202@icid.cu>
	<51110A7E.4020506@icid.cu>
In-Reply-To: <51110A7E.4020506@icid.cu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] about switchtest ...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: raespi <raespi@icid.cu>
Cc: xenomai@xenomai.org

On 02/05/2013 02:34 PM, raespi wrote:

> Still on this topic ... do the CFLAGS and LDFLAGS parameters are checked 
> only from the ./configure command line or are they also checked by 
> Xenomai as an environment variable ??  I'm currently in discussion with 
> the buildroot maintainer about this topic to fix this problem ...


Xenomai does not do anything special, it uses the autotools default
which is:
- if you pass CFLAGS and LDFLAGS on the right hand of the configure
command line, the generated makefiles are hardcoded with these flags
values, and you need not do anything special later on to get these flags
used for all the compilations. This has been the recommended way of
passing CFLAGS and LDFLAGS when building autotools-based projects for
many years.

- if you want to pass them as environment variables (so, on the left
hand of the configure command line), the makefiles are not generated
with these flags, so, you have to pass them in the environment of the
"make" command.

-- 
                                                                Gilles.

