MIME-Version: 1.0
References: <AS8PR08MB6485F2F96F74EC13047326909A629@AS8PR08MB6485.eurprd08.prod.outlook.com>
In-Reply-To: <AS8PR08MB6485F2F96F74EC13047326909A629@AS8PR08MB6485.eurprd08.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 25 Mar 2021 12:20:17 -0400
Message-ID: <CALLqZ8SY=ffUVwiYH8J=_KmUWh8NGgAqaVuHm74GW26=NNY9yg@mail.gmail.com>
Subject: Re: Hardware support by Xenomai 3.1
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Zhao, Lixiang" <Lixiang.Zhao@leoni.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Mar 25, 2021 at 12:01 PM Zhao, Lixiang via Xenomai <
xenomai@xenomai.org> wrote:

> Hi,
>
> I would like to patch a board with a Rockchip RK3399 SoC with Xenomai
> v3.1, I'm unsure if this SoC is supported, could you help me find it out ?
>
> Best regards,
> Li.
>

I don't think it's been ported to the ipipe yet (looking at ipipe 5.4).  If
you look at what interrupt sources the board has you can see if the drivers
are already ipipe aware.  If they aren't you can port them over, there's a
good porting guide in the documentation directory, it's for ARM but most of
it applies to ARM64.  I have a RK3308 that I keep meaning to try port, but
with my schedule I don't think I'll get around to it for a while.

-Greg
