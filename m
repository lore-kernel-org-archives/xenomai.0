Message-ID: <52204A42.5080208@aaton.com>
Date: Fri, 30 Aug 2013 09:31:14 +0200
From: Nicolas Pinault <nicolasp@aaton.com>
MIME-Version: 1.0
References: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
	<521F409D.4070507@siemens.com>
	<CAMZj-5OASu0jYzT=7JXHjQxULUNhurOTC5RQqt2X=rU0wHMxTA@mail.gmail.com>
In-Reply-To: <CAMZj-5OASu0jYzT=7JXHjQxULUNhurOTC5RQqt2X=rU0wHMxTA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Virtualization with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
>> In Windows world, use RTX :
> http://www.intervalzero.com/products/rtx-rtx64/overview/
> In fact, if I change from Xenomai Linux to Windows, first I will remove all
> the real-time applications from that board and run them in the other one.
> Anyway, it's an interesting link.
>
Just for your knowledge : Rtx can be used with single-core or multi-core 
processors. In case of a multi-core processor, 1 or more core can be 
dedicated to real-time applications. You have to write a GUI application 
and a real-time application. Both communicate with each other through a 
dedicated API. Rtx is perfectly integrated in the dev tools (visual 
studio). On a Rtx enabled system, standard applications continue to run 
normally. The main drawback is the price.

Nicolas

