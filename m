Message-ID: <51111E46.4070706@xenomai.org>
Date: Tue, 05 Feb 2013 15:59:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu>
	<510FFE7C.1090601@xenomai.org>	<51100A6B.90701@icid.cu>
	<5110122C.2090807@xenomai.org>	<511021FC.7080906@icid.cu>
	<51102316.9090107@xenomai.org>	<511027E6.4080202@icid.cu>
	<51110A7E.4020506@icid.cu> <51111CC2.3040204@xenomai.org>
	<51111DB6.4030809@icid.cu>
In-Reply-To: <51111DB6.4030809@icid.cu>
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

On 02/05/2013 03:56 PM, raespi wrote:

> The problem was fixed ... The buildroot system didn't pass the specific 
> CFLAGS and LDFLAGS for my machine.  In your Getting Started guide this 

> is something necessary.  That's what fixed the problem and allowed me to 
> run the tests.  What I'm checking with him is how those flags are passed 
> to Xenomai.  Perhaps he didn't notice it before since no one ran the 
> test suite for this machine ?? IDK ...


No, read my answer again. If buildroot did not pass correct CFLAGS or
LDFLAGS, you would get an "illegal instruction" trap. So, you have not
really understood what your problem is, and you have not understood why
passing specific CFLAGS and LDFLAGS in addition to the ones passed by
buildroot fixes it.

-- 
                                                                Gilles.

