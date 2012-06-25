Message-ID: <4FE80E4E.6060709@siemens.com>
Date: Mon, 25 Jun 2012 09:07:58 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CC0C8DD9.206BE%glen@jetsoftdev.com> <4FE718A3.7030102@xenomai.org>
In-Reply-To: <4FE718A3.7030102@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] USB for Xeno
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Glen Wernersbach <glen@jetsoftdev.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-06-24 15:39, Gilles Chanteperdrix wrote:
> On 06/24/2012 03:26 PM, Glen Wernersbach wrote:
>> Hello,
>> Has anyone successfully incorporated USB into RTDM for Xeno?
>>
>> I need to have two xeno boxes talk to each other real time over usb. One as
>> host and one responding as a device.
>>
>> Glen
> 
> Hi,
> 
> a project exists providing USB drivers for xenomai:
> http://developer.berlios.de/projects/usb4rt
> 
> However, I do not know what its current status is.
> 

Dead ATM, but we are planning a reanimation. Note that this is only
addressing USB 1.1 so far and EHCI is not yet on our agenda.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux



