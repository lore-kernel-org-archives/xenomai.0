MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2015 08:14:43 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <9cf75cdcc753b7abfa0763ebd5ae1d91@grandegger.com>
References: <CAEMXjGxz2YZFL0mqpq=8c9ojUvNdw6mUSOy8cQCd5HYWHz06fQ@mail.gmail.com>
 <CAEMXjGzwez_k+3Qo-_ZJ4FvbOtLV2MjR0aV_tkeiRdGGaq4MAQ@mail.gmail.com>
 <CAEMXjGxtHB43N5oWL58F2y5rOH-yMycNaWtr+EDs009y1QJUcw@mail.gmail.com>
 <CAEMXjGykL_xTAteJ=Bz10jjL0xr9Uw1YBJpV=sV43Fkw=GAwug@mail.gmail.com>
 <9cf75cdcc753b7abfa0763ebd5ae1d91@grandegger.com>
Message-ID: <3f27a9331a6514bb01d05d67fca0da4f@grandegger.com>
Subject: Re: [Xenomai] 16550 serial driver on Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, 13 Feb 2015 08:10:23 +0100, Wolfgang Grandegger
<wg@grandegger.com> wrote:
...
> Maybe unbinding the Linux device from the driver as shown below (for
> another
> device) already helps:
> 
> # echo f0002400.serial \
>    /sys/devices/f000.soc5200/f0002400.serial/driver/unbind

Oops, the redirection ">" is missing!

Wolfgang,



