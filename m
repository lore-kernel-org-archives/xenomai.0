Message-ID: <51111CC2.3040204@xenomai.org>
Date: Tue, 05 Feb 2013 15:52:50 +0100
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


I am not sure you should bother the buildroot maintainer until you have
understood what the real problem is. Because if you do not compile for
the right machine, you should get illegal instructions, not the error
you report.

-- 
                                                                Gilles.

