Message-ID: <4E1AF868.7030203@domain.hid>
Date: Mon, 11 Jul 2011 15:19:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E157F1C.9060606@domain.hid> <4E1ADC25.5000800@domain.hid>
	<4E1AF2AD.8070909@domain.hid>
In-Reply-To: <4E1AF2AD.8070909@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 32 bits libraries for x86_64 architecture
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Mathiassen <kimmat@domain.hid>
Cc: xenomai@xenomai.org

On 07/11/2011 02:55 PM, Kim Mathiassen wrote:
> On 07/11/2011 01:19 PM, Gilles Chanteperdrix wrote:
>> So, currently, it seems easier to use either a complete 64 bits or  to a
>> complete 32 bits system, not a mix of both.
>>
> Thanks for the reply. I have been implementing the deamon approach. It 
> seems to be working. Unix sockets can communicate between 32 and 64 bit 
> programs.

Yes, but make you switch to secondary mode. IOW, you no-longer are
real-time.

-- 
					    Gilles.

