Message-ID: <52EBABF6.3080706@siemens.com>
Date: Fri, 31 Jan 2014 14:58:14 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <52EBA6D0.2010208@siemens.com> <52EBAAC3.7090105@xenomai.org>
In-Reply-To: <52EBAAC3.7090105@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-01-31 14:53, Gilles Chanteperdrix wrote:
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

Well, the way we transport the information is one thing (xeno-config vs.
pkg-config - I'm not against the latter!), but this question is related
to the content first of all.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

