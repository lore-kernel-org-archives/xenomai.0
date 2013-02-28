Message-ID: <512FB80B.7000207@xenomai.org>
Date: Thu, 28 Feb 2013 21:03:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512E8C10.8080707@ruggedcom.com> <512E904A.2080408@xenomai.org>
	<512E9417.20708@ruggedcom.com> <512EE94A.8000802@xenomai.org>
	<512F7043.20900@ruggedcom.com>
In-Reply-To: <512F7043.20900@ruggedcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Is CLOCK_HOST_REALTIME supported for powerpc?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Makarand Pradhan <makarandpradhan@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/28/2013 03:57 PM, Makarand Pradhan wrote:

> On 28/02/13 12:21 AM, Gilles Chanteperdrix wrote:
>> 2.6.2.1 is the latest release, please do not use 2.6.2. 2.6.2.1 is in
>> the same branch as 2.6.0, so it is completely ABI and API compatible.
>> Anyway, you do as you wish, but please do not expect support from us for
>> 2.6.0.
> Thanks Gilles. Will investigate the relevant Ipipe pathes to check 
> support for powerpc.


All old I-pipe patches should work with the latest version of xenomai,
though as I said, whether CLOCK_HOST_REALTIME work probably depends more
on the I-pipe patch.

-- 
                                                                Gilles.

