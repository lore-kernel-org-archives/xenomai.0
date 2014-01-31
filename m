Message-ID: <52EBAFB4.6000508@xenomai.org>
Date: Fri, 31 Jan 2014 15:14:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52EBA6D0.2010208@siemens.com> <52EBAAC3.7090105@xenomai.org>
In-Reply-To: <52EBAAC3.7090105@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] forge/cobalt: Do we need to wrap all POSIX calls for
 non-POSIX skins?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/31/2014 02:53 PM, Gilles Chanteperdrix wrote:
> On 01/31/2014 02:36 PM, Jan Kiszka wrote:
>> Hi,
>>
>> was asked why, e.g., xeno-config --skin=alchemy --ldflags returns
>> -Wl,@/data/xenomai-forge/inst64/lib/cobalt.wrappers. Is there a
>> technical reason? On first glance and after minimal testing, it seems
>> not.
>
> Maybe we could drop xeno-config entirely, and move to pkg-config? This
> forces users which develop for Xenomai to have pkg-config installed, but
> who does not have it these days?
>
>

xeno-config is sometimes used on the target as well, for retrieving 
installation parameters.

-- 
Philippe.

