Message-ID: <51F1820E.4030805@xenomai.org>
Date: Thu, 25 Jul 2013 21:52:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABSOR2gjLVQdXoxdPDHf6kuh-HT-XRPSj42vLP975-q2PR=jkw@mail.gmail.com>
In-Reply-To: <CABSOR2gjLVQdXoxdPDHf6kuh-HT-XRPSj42vLP975-q2PR=jkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai application tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ILESH PATEL <patelilesh01@gmail.com>
Cc: xenomai@xenomai.org

On 07/20/2013 04:59 PM, ILESH PATEL wrote:

> Hi,
>
> I used iperf network testing utility on my network.
> My PC is configured with ubuntu 12.04 with Xenomai 2.6.2.1
>
> So, I want to know iperf utility is running with real time environment path
> or non real time environment path.
>
> Please Give me hits tracing application.
> So, I can know this application response is real time or non real time.


It is a bit hard to know what you are testing, I mean you compiled 
iperf, we have no idea how you compiled it. So, to be safe, we will say, 
no, probably not, iperf is not using xenomai services.

-- 
                                                                 Gilles.

