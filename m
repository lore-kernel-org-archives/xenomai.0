Message-ID: <51755423.2040706@nta-inc.net>
Date: Mon, 22 Apr 2013 10:15:47 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <201304191346.38739.leo@alaxarxa.net>
	<517195B6.8020209@xenomai.org>
	<12ABCC03-FADF-4C5A-9CAE-CD9E5CA63A19@mah.priv.at>
In-Reply-To: <12ABCC03-FADF-4C5A-9CAE-CD9E5CA63A19@mah.priv.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Default options in the debian package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 04/20/2013 01:04 AM, Michael Haberler wrote:
>
> Am 19.04.2013 um 21:06 schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
>> On 04/19/2013 01:46 PM, Leopold Palomo-Avellaneda wrote:
>>
>>> [1]
>>> http://lists.mech.kuleuven.be/pipermail/orocos-users/2013-April/006986.html
>>
>>
>> Hi,
>>
>> that link does not tell us why you need this option. And that would be
>> the most important information.
>
> with the linuxcnc package build I need to turn on --enable-dlopen-skins as well to get Python modules to work properly
  
For what it's worth, we use --enable-dlopen-skins (and build Python modules) for some of our applications as well.

-Jeff


