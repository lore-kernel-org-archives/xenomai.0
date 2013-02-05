Message-ID: <51112476.2030500@xenomai.org>
Date: Tue, 05 Feb 2013 16:25:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu>
	<510FFE7C.1090601@xenomai.org>	<51100A6B.90701@icid.cu>
	<5110122C.2090807@xenomai.org>	<511021FC.7080906@icid.cu>
	<51102316.9090107@xenomai.org>	<511027E6.4080202@icid.cu>
	<51110A7E.4020506@icid.cu> <51111CC2.3040204@xenomai.org>
	<51111DB6.4030809@icid.cu> <51111E46.4070706@xenomai.org>
	<511122D3.8000501@icid.cu>
In-Reply-To: <511122D3.8000501@icid.cu>
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

On 02/05/2013 04:18 PM, raespi wrote:

> Facts:
> 1- Buildroot doesn't build correctly the Xenomai package ( test suite 
> fails to launch )
> 2- When passing the flags in Buildroot manually ( for now ) to the 
> Xenomai package the test suite runs normally


I Agree with these two, but what I ask you is why?

> 3- The solution is either fixing the parameter passing scheme on Xenomai 
> or how Buildroot passes the parameters ( I go with this last one ).


Disagree with this one, which is a shortcut, not a real conclusion.
There may be a bug, what you have found is a workaround, not a solution.

-- 
                                                                Gilles.

