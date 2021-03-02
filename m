MIME-Version: 1.0
References: <SN6PR08MB5661FBDD5171C06547422CD293999@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB5661FBDD5171C06547422CD293999@SN6PR08MB5661.namprd08.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 2 Mar 2021 18:45:05 -0500
Message-ID: <CALLqZ8R7ktiYDEAUUqquVhM8CBXco8Kvr7nV3CFX18ggEOno7w@mail.gmail.com>
Subject: Re: Cannot disable Page migration on kernel configuration
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriel Dinse <gabriel_dinse@hotmail.com>
Cc: xenomai@xenomai.org

On Tue, Mar 2, 2021 at 6:43 PM Gabriel Dinse via Xenomai <
xenomai@xenomai.org> wrote:

> When configuring kernel (4.19.144 arm) through menuconfig, I get the
> following warning:
> [*] Xenomai/cobalt  --->
> *** WARNING! Page migration (CONFIG_MIGRATION) may increase ***
> *** latency. ***
>
> But I'm not able to disable it:
> Memory Management options  --->
>          -*-   Page migration
>
> Is it possible to do it different than using menuconfig?
>
> Thank you,
> Gabriel Dinse
>
> Are you using multiv7_defconfig? Try disabling the imx platform in menu
config then try disabling page migration and CMA.

-Greg
