Message-ID: <5463264B.3090503@sigmatek.at>
Date: Wed, 12 Nov 2014 10:20:11 +0100
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <54631EB1.1050900@sigmatek.at> <546323F9.9040608@xenomai.org>
In-Reply-To: <546323F9.9040608@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_nrtsig_pend FAQ
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am 12.11.2014 um 10:10 schrieb Philippe Gerum:
> nrt signals are based on I-pipe virtual irqs, which do not pile up:
> there is a single signal pending until the irq can be delivered to the
> handler, regardless of how many times it has been triggered.
i know, if there is a big cpu load some virtual irqs can be lost, but we 
have cpu load smaller that 10 percent.




