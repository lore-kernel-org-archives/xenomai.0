Message-ID: <53564F83.4070401@control.lth.se>
Date: Tue, 22 Apr 2014 13:16:19 +0200
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <CAC66z97Q39YpEQ8aug7DqnCM-+cQ8NRAVgFHLgJamgbqjV4PfA@mail.gmail.com>
In-Reply-To: <CAC66z97Q39YpEQ8aug7DqnCM-+cQ8NRAVgFHLgJamgbqjV4PfA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM: Ethernet driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: yogesh garg <yogesh.garg1983@gmail.com>, xenomai@xenomai.org

On 04/22/2014 11:45 AM, yogesh garg wrote:
>   I want to write Ethernet (NIC) driver on Xenomai using RTDM. I don't want
> to use RTnet.
Why not?

RTnet does not imply that you have to use the RTnet protocol, it's
perfectly fine to use just the Ethernet drivers as you see fit
(that's what I do all the time).

By going your own way, realtime ethernet for Xenomai will be fragmented,
which will benefit nobody (except possibly WindRiver/Microsoft/...)
> Can someone suggest me any example code or useful links/docs
> which can help me to do so.
>

/Anders

--
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden





