Message-ID: <51CB231E.8030600@xenomai.org>
Date: Wed, 26 Jun 2013 19:21:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201306260906.22955.leo@alaxarxa.net>
In-Reply-To: <201306260906.22955.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai warn_upon_switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/26/2013 09:06 AM, Leopold Palomo-Avellaneda wrote:

> Hi,
> 
> since 2.6.x the Orocos users have difficulties (or simple cannot) use Xenomai. 
> Despite of some bug in the Orocos code, xenomai emits a warn_upon_switch that 
> makes the user to use a console program - deployer - (basically for the orocos 
> philosofy) to launch rt programs.
> 
> I think that this signal must be treated in some way by the Orocos code, but 
> it's not developed yet. Since then, there's a way to silent this signal, or 
> simple that doesn't overflow the console but thousand of messages like this:


In case it is a bug which has already been fixed, could you try xenomai
2.6 git?

-- 
                                                                Gilles.

