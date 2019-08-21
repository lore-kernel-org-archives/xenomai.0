Subject: Re: [xenomai-images][PATCH v3] kernel/linux-xenomai: Update versions
References: <20190819101746.6769-1-Quirin.Gylstorff@siemens.com>
 <20190820151707.13840-1-Quirin.Gylstorff@siemens.com>
 <22065707.2yBTX3zYjI@omoikane>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <736860b6-561c-58ce-c89d-1071e67b1f77@siemens.com>
Date: Wed, 21 Aug 2019 12:42:47 +0200
MIME-Version: 1.0
In-Reply-To: <22065707.2yBTX3zYjI@omoikane>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "steven.seeger flightsystems.net" <steven.seeger@flightsystems.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Quirin Gylstorff <quirin.gylstorff@siemens.com>

On 21.08.19 12:07, steven.seeger flightsystems.net via Xenomai wrote:
> Hi Quirin. It looks like I need to move powerpc over to 4.19 as well. I have
> been discussing this with some industry partners.
> 

In fact, there is even no ppc support for xenomai-images yet. At least a qemu 
virtual test target would be of high value, though.

I was briefly discussing this with Quirin, but there are some risks, 
effort-wise. First, we have no idea if Debian/Isar will "just work" for a ppc32 
target - likely no one did that before, though adding MIPS to Isar was trivial. 
And then we have no idea about the required qemu-system setup to test the 
result. I mean, we could have a look but we may quickly need support by a ppc 
expert or need to stop again when things become too nasty.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

