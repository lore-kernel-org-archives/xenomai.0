MIME-Version: 1.0
In-Reply-To: <524D70A4.6020007@xenomai.org>
References: <524ABEED.4090609@axelsw.it>
	<114ba7d302c4a7b01d85caf23c52fa10.squirrel@127.0.0.1>
	<524AC518.2040901@axelsw.it> <524B1E12.2010909@xenomai.org>
	<524D2C77.6050706@axelsw.it> <524D70A4.6020007@xenomai.org>
Date: Thu, 3 Oct 2013 15:33:45 +0200
Message-ID: <CAEk6gTB+KRO_3_x+i8hOiGXeRxSXP9WMk42CJCnz87SWSdKQjQ@mail.gmail.com>
From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] high latency with imx6q without smp
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

On Thu, Oct 3, 2013 at 3:27 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 10/03/2013 10:36 AM, Roberto Bielli wrote:
>> Hi,
>>
>> i reduced drastically the latency disabling the cpu frequency scaling ->
>> CONFIG_CPU_FREQ ( max 25us ).
>
> This seems a bit too good to be true. Chances are higher to approach the
> real worst case latency on a system under load.

Can xeno-test give good and reliable figures for this case?

BR,
Drasko

