Subject: Re: Analogy: analogy_config freezes computer
References: <VI1PR02MB4749FFC72B59123C0A44297E86230@VI1PR02MB4749.eurprd02.prod.outlook.com>
 <ae7e55e6-224c-3590-471b-f1dbf49a81d5@xenomai.org>
 <PR1PR02MB474898400BAE6B59A24A30F8863A0@PR1PR02MB4748.eurprd02.prod.outlook.com>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <f347edf5-5097-04a1-c5a4-c8f5716ed733@xenomai.org>
Date: Tue, 30 Apr 2019 16:49:21 +0200
MIME-Version: 1.0
In-Reply-To: <PR1PR02MB474898400BAE6B59A24A30F8863A0@PR1PR02MB4748.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florent Legendre <florent.legendre@live.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 4/30/19 16:00, Florent Legendre wrote:
> Hello,
>
> Thanks a lot for your reply and sorry for the delay.
>
> You are right, it's NI PCI-6259. (sorry, typing mistake)
>
> Currently, l don't have time to go deeper in this problem, other
> priorities came up. But I will very soon be back on this topic.
>
> Thanks again, I wish you a great day !

Hi Florent

can you reinstall your kernel after enabling the configs below and re-test?

XENO_DRIVERS_ANALOGY_DEBUG

XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL 10

XENO_DRIVERS_ANALOGY_DEBUG_LEVEL 10

thanks

Jorge


