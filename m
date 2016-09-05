References: <tencent_0665C5E346CB72916FA20B7D@qq.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <2f22ed42-f3e0-991d-01db-29372ef47880@grandegger.com>
Date: Mon, 5 Sep 2016 13:47:51 +0200
MIME-Version: 1.0
In-Reply-To: <tencent_0665C5E346CB72916FA20B7D@qq.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt-socket-can "no device" problem with advantech
 PCM-26D2CA CANboard [CLOSED]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

Hello Jack,

Am 05.09.2016 um 13:30 schrieb Jack Lee:
> Wolfgang has solved this problem.
> This problem occurs, because rt-socket-can driver in xenomai 3.0.2 does
> not have the Advantech PCM26D2CA device yet. It's device id is 0xC302.
> Below is the the final patch. I have tested it. It works fine :)

Apart from the missing PCI id entry, there are other issues with mapping 
the PCI address space. I actually wonder how it could work with other 
cards. I'm going to rework the device mapping for inclusion in the 
Xenomai repo later this week.

Wolfgang.

