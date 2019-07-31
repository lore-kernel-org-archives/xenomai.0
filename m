Subject: Re: Fwd: TDMA with RTnet on Xenomai
References: <CAEmXcAwXBxZp9KcRyMs9J08nLKnwkYn13BuWPKTZ-pb6m95chg@mail.gmail.com>
 <b88d839c-eb9f-8712-eb47-5a5fc12cbf17@siemens.com>
 <CAEmXcAxMWcK1wsTQFJ2uQpJ1yjQiyfhoB5C-O=-bh-FTinNMjg@mail.gmail.com>
 <0fd69e88-c0db-f9ef-c8a1-b5d25afe917f@siemens.com>
 <CAEmXcAw+c-nBfMWRpU4yT_GbczRwwGCk=MFKh-g1F_tzwRytLQ@mail.gmail.com>
 <80b77618-4a1f-5554-1dfd-aa2369b3252f@siemens.com>
 <CAEmXcAzd3P9DkRHVbtvzgB_J52gUtaVd19h8=r-VL4frp0Gm3Q@mail.gmail.com>
 <CAEmXcAyPAnDa2OhQn-JoZo3cY6HN9BtBdtNAr5i0hpQ0UPvpZg@mail.gmail.com>
 <64f13545-b3a8-3c5d-1b0e-b953515f0f12@siemens.com>
 <CAEmXcAw_Qek1jEguriG51MKoosN2QOVuAOHSjkW0j43rinryHA@mail.gmail.com>
 <d74187a6-761f-4fd8-bf5a-bf72f58b6fd9@siemens.com>
 <CAEmXcAypMd=+XLd7iiy0vgFZmB2hYzPp4VpvTV24w+SSY_OSxQ@mail.gmail.com>
 <a63f3370-fa4d-32e8-33c3-8fb6da24841d@siemens.com>
 <CAEmXcAxkjsXpkbw9UB-A59Qp6ZPN_pa3yq6_pXRvyicvEVKLmA@mail.gmail.com>
 <CAEmXcAznrMTT6hiNjyQHtzCRoKJR2Bnfs49KqTVw6r1G+HssfQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b3b24c21-d18a-9a36-5b0d-7cce1256591b@siemens.com>
Date: Wed, 31 Jul 2019 11:29:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAEmXcAznrMTT6hiNjyQHtzCRoKJR2Bnfs49KqTVw6r1G+HssfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: danwe <daniel.wenninger92@gmail.com>, xenomai@xenomai.org

On 31.07.19 10:55, danwe via Xenomai wrote:
> I have found that my modules are loading via "modprobe".
> You wrote:
> "Ah, you are on legacy, out-of-tree RTnet! I forgot that RTnet only moved
> into
> Xenomai for version 3.0. For 2.x, you are with the old repo that wasn't
> touched
> since 2013. In this particular case, the script fails early because of
> "insmod
> <existing-module>", rather than using "modprobe" like in Xenomai upstream".
> 
> So in my S51rtnet it loads modules like this:
> for i in rtnet rt_smsc rt_davinci_mdio rt_ticpsw rtpacket rtipv4 rtmac
> rtcfg tdma
> do
>      echo -n"$i "
>     modprobe ${i}
>     sleep 1
> done
> 
> As you write "rather than using "modprobe" like in Xenomai upstream"...
> should tdma work on Xenomai 2 / RTnet here or is it just a problem because
> of ouf-of-tree RTnet?

The problem is you have two scripts now working against each other. The legacy
start script from legacy RTnet would do the heavy-lifting for RTmac/TDMA & Co.
but stumbles over insmod for an already loaded module. And your own start script
uses the right insmod but only does that, nothing for the full configuration.
Remove the latter, and you may get further - unless legacy RTnet has more surprises.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

