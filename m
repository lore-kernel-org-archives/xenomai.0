Subject: Re: IMX8M Nano compatibility
References: <VI1PR04MB404687DFF801F6DFCDCF8617F3EA9@VI1PR04MB4046.eurprd04.prod.outlook.com>
 <7e1e996a-94ac-9522-f3f8-0816c128753f@siemens.com>
 <CAEfxd-8mXL6ojaxGUZmNsrPMNc6f0r_jTktHnZiewVTy=b7QJg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <896e26e2-8752-0174-3299-a7dd1aaa84a4@siemens.com>
Date: Thu, 29 Jul 2021 11:12:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAEfxd-8mXL6ojaxGUZmNsrPMNc6f0r_jTktHnZiewVTy=b7QJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peng Fan <van.freenix@gmail.com>
Cc: "Kristiansen, Morten (INT)" <Morten.Kristiansen@teledyne.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 29.07.21 10:48, Peng Fan wrote:
> Jan Kiszka via Xenomai <xenomai@xenomai.org
> <mailto:xenomai@xenomai.org>> 于2021年7月29日周四 下午3:39写道：
> 
>     On 28.07.21 15:47, Kristiansen, Morten (INT) via Xenomai wrote:
>     > Hi Everybody.
>     >
>     > I have a boot problem on IMX8M Nano.
>     >
>     > NXP provide a ported kernel for their evaluation board based on
>     Linux 5.4.70. (https://source.codeaurora.org/external/imx/linux-imx
>     <https://source.codeaurora.org/external/imx/linux-imx>,
>     branch imx_5.4.70_2.3.0)
>     >
> 
>     You generally don't want to use this, you want an upstream version.
> 
> 
> Jan,
> 
> Do you see an issue with that version?

It's not upstream, thus not able to provide official stable interfaces.
And it didn't pass the extra upstream QA yet. And my not live long
enough to be used in products. The common vendor kernel problem.

Plus, when you combine things with another downstream patch series -
that's what Xenomai is responsible for -, things do not become simpler.

Sorry, just burned again, not by NXP, but by the same pattern.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

