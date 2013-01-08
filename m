Message-ID: <50EC7981.6050002@xenomai.org>
Date: Tue, 08 Jan 2013 20:54:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50EB4DB3.4040207@xenomai.org>
	<201301081012.47861.leo@alaxarxa.net>
In-Reply-To: <201301081012.47861.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian squeeze packages preview for the
	amd64	architectures
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On 01/08/2013 10:12 AM, Leopold Palomo-Avellaneda wrote:

> A Dilluns 07 Gener 2013, Gilles Chanteperdrix va escriure:
>>
>> Hi,
>>
>> For the Debian squeeze users, the xenomai packages are available on
>> xenomai server, for the amd64 architecture. To use them, add:
>>
>> deb http://www.xenomai.org/debian squeeze main
>>
>> to /etc/apt/sources.list, then:
>> apt-get update
>> apt-get install xenomai-keyring
>> apt-get install linux-image-3.5.7-xenomai-2.6.2 xenomai-runtime
>>
>> You should then be able to reboot on the new kernel, and launch:
>> xeno latency
>>
>> These packages are a preview version, not really 2.6.2, but not yet the
>> next release.
>>
> 
> great!!!
> 
> Please Gilles, the linux image is produced using an standard stock version 
> (just patched with xenomai)?


Yes, this is vanilla linux 3.5.7 with the xenomai patch applied, and a
kernel configuration derived from debian configuration for linux 3.2,
enabling every new option (as a module if possible) in 3.5 compared to 3.2.

-- 
                                                                Gilles.

