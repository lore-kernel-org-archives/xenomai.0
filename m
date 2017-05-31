References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
Date: Wed, 31 May 2017 09:16:58 +0200
MIME-Version: 1.0
In-Reply-To: <1496167354451.78382@kth.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the raspberry pi
 2 (or 3)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/30/2017 08:02 PM, Nitin Kulkarni wrote:
> Hi Philippe,
>>From your reply I guess its the same issue  with my SoC also. Do you think in my case the Intel joule pinctrl driver is not aware of Ipipe ?
> Do you have any instances where an x86 based SoC was ported to solve this issue ?
> Thanks for the info it explains a lot of things now.

What is the output of /proc/interrupts on your board?

-- 
Philippe.

