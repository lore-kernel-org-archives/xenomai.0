Message-ID: <51CEED98.40503@xenomai.org>
Date: Sat, 29 Jun 2013 16:22:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <201306260906.22955.leo@alaxarxa.net>	<51CC031A.9030905@xenomai.org>	<CAMYDobV2YQez7qtcTxxQ1wsL23oPu0sT+WwHsQ6hW18pcgnJkA@mail.gmail.com>
	<201306290134.51737.leo@alaxarxa.net>
	<51CEE9AC.2090602@xenomai.org>
In-Reply-To: <51CEE9AC.2090602@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/29/2013 04:05 PM, Gilles Chanteperdrix wrote:
> On 06/29/2013 01:34 AM, Leopold Palomo Avellaneda wrote:
>
>> How can I know the version of a tree of files of xenomai?
>
>
> For the kernel-space part, the version appears in the boot messages
> (dmesg).

/proc/xenomai/version as well.

> For the user-space part, you can not see the version at run-time, the
> version is in the config/version file in xenomai sources.

xeno-config --version would do.

>
> For the problem you have, you only need kernel-space from 2.6.2.1.
> User-space does not matter. You can also check in the sources if you
> have the following patch applied:
>
> http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=6641c821c015d9fece07b8ac60c210cb9b0307a4;hp=943b5b3297ed996794a7fabf37bd57329b77293f
>
>


-- 
Philippe.

