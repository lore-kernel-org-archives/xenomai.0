Subject: Re: TDMA with RTnet on Xenomai
References: <CAEmXcAwXBxZp9KcRyMs9J08nLKnwkYn13BuWPKTZ-pb6m95chg@mail.gmail.com>
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
 <CAEmXcAzO0+OfMM2UuvXWr5K=KHwrTz1UQa7-YEF85g48VGmbdQ@mail.gmail.com>
 <6846d8f8-3d03-58e2-40c8-73ac3d1da964@siemens.com>
 <CAEmXcAw-9rpc7C+4VeJxQM5dxhYgPAhw=j+_xvmuSqAdtKaTgg@mail.gmail.com>
 <15c11a1e-6536-7639-eb55-6a5a264b9438@siemens.com>
 <CAEmXcAxwttnRUnOO8G5Oy_AWkP5fYy3uU7Am2UEZccNs=OJoww@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b6b74174-7e14-afb0-fe98-7afab7d55f2d@siemens.com>
Date: Thu, 25 Jul 2019 14:49:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAEmXcAxwttnRUnOO8G5Oy_AWkP5fYy3uU7Am2UEZccNs=OJoww@mail.gmail.com>
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

On 25.07.19 14:18, danwe wrote:
>     The driver needs to be for the Ethernet controller on that SoC, yes. Structures
>     of such drivers are similar, details aren't. You can easily check that by
>     comparing some in-tree drivers.
> 
> 
> Do you know the name of the driver for the Ethernet controller in a normale
> Xenomai / RTnet project? As those config-files I wrote are just files for
> buildroot. I'm sure that these are not files for any driver. So I thought it
> would be much better to compare the driver for Ethernet controller in a normal
> Xenomai / RTnet project to that driver which I have for the old Kernel and the
> old RTnet. But I don't find it, I don't get the drivers name.
> 

There is none for the BBB's cpsw ("ti,am335x-cpsw"), neither in Xenomai nor the
old RTnet. If you have something running locally, someone must have given you
downstream changes.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

