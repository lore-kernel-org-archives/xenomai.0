MIME-Version: 1.0
In-Reply-To: <7f31d707-5a9d-8407-d48f-6093d1ccd7f1@xenomai.org>
References: <1517365725-4608-1-git-send-email-greg@embeddedgreg.com>
 <7f31d707-5a9d-8407-d48f-6093d1ccd7f1@xenomai.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 1 Feb 2018 10:26:35 -0500
Message-ID: <CALLqZ8RgiLys92todoYYhZUbnp3YbpTDQiY0YREpZdqSTAH_Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [PATCH] Fix up the imx uart driver so it now compiles
 with new kernels.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Makes sense, after the fact I realized this would diverge from the
mainline structs.  Will fix up and update.

On Thu, Feb 1, 2018 at 5:02 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 01/31/2018 03:28 AM, Greg Gallagher wrote:
>> This patch is based on one that was submitted by Wolfgang Netbal back in Feb
>> 2016 but a formal patch was never submitted.
>> I added a couple small changes (style errors and imx7 define) and tested on a
>> imx7d board. One quick note, the IMX7D define may not really be needed since
>> most imx7 uarts look to be compatible with imx6.
>
> I would drop this additional definition. DT indeed says that imx7d uarts
> can be handled by the i.MX serial driver as imx6q devices, and
> fsl,imx7d-uart is a mere alias to fsl,imx6q-uart AFAICS in the mainline
> tree up to 4.15.
>
> --
> Philippe.

