Message-ID: <4E982DCE.2030107@domain.hid>
Date: Fri, 14 Oct 2011 14:40:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E981AFB.40106@domain.hid> <4E982CAE.8080906@domain.hid>
In-Reply-To: <4E982CAE.8080906@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL] KVM awareness / tiny cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On 2011-10-14 14:35, Gilles Chanteperdrix wrote:
> On 10/14/2011 01:20 PM, Jan Kiszka wrote:
>> The following changes since commit 31bdadef9018de586bc3fe8de0f37b62b2507785:
>>
>>   testsuite: fix regression tests location (2011-10-14 01:46:08 +0200)
>>
>> are available in the git repository at:
>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>
>> Jan Kiszka (2):
>>       nucleus: Privatize __xnpod_reset_thread
> 
> Are we sure that we do not have any out-of-tree users for this feature?

Out-of-tree would be impossible as that function was not exported.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

