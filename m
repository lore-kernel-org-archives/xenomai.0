Message-ID: <516D0502.4090703@grandegger.com>
Date: Tue, 16 Apr 2013 10:00:02 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <oqr4jdyggv.fsf@merlin.sez.to> <51646CBA.40407@xenomai.org>
	<51653957.2070405@grandegger.com> <516AC595.5060103@xenomai.org>
	<516B9C3F.2080107@grandegger.com> <oqr4icp8ie.fsf@merlin.sez.to>
In-Reply-To: <oqr4icp8ie.fsf@merlin.sez.to>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] rtcan_module: Fix tx_timeout buffer size
 inconsistency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>
Cc: Wolfgang Grandegger <wg@denx.de>, xenomai@xenomai.org

Hi Paul,

On 04/15/2013 09:18 AM, Paul Janzen wrote:
> Wolfgang Grandegger <wg@grandegger.com> writes:
> 
>>> We have two other unconfirmed CAN patches:
>>> http://www.xenomai.org/pipermail/xenomai/2013-March/028111.html
>>
>> We can add even more PCI IDs here. I'm going to prepare a patch. Just
>> support for 4 channel cards needs more effort.
> 
> Along these same lines, would there be any interest in a patch
> removing the deprecated ESD PCI-CAN driver?

It does not make a lot of sense to maintain two variants of a driver.

> All of the devices claimed by that driver are supported by PLX_PCI.

Yes, I will check if there are some relevant differences.

Wolfgang.


