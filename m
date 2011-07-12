Message-ID: <4E1BF6B6.1000401@domain.hid>
Date: Tue, 12 Jul 2011 09:24:38 +0200
From: Kim Mathiassen <kimmat@domain.hid>
MIME-Version: 1.0
References: <4E157F1C.9060606@domain.hid> <4E1ADC25.5000800@domain.hid>
	<4E1AF2AD.8070909@domain.hid> <4E1AF868.7030203@domain.hid>
In-Reply-To: <4E1AF868.7030203@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: xenomai@xenomai.org

On 07/11/2011 03:19 PM, Gilles Chanteperdrix wrote:
> On 07/11/2011 02:55 PM, Kim Mathiassen wrote:
>> On 07/11/2011 01:19 PM, Gilles Chanteperdrix wrote:
>>> So, currently, it seems easier to use either a complete 64 bits or  to a
>>> complete 32 bits system, not a mix of both.
>>>
>> Thanks for the reply. I have been implementing the deamon approach. It
>> seems to be working. Unix sockets can communicate between 32 and 64 bit
>> programs.
> Yes, but make you switch to secondary mode. IOW, you no-longer are
> real-time.
>
Only the thread communicating with Unix sockets will go to secondary 
mode? I guess there is no way of getting the labview threads to Xenomai 
threads? If there is no way of getting the labview threads to real-time 
threads, at least some of the code will run in real-time mode. I will 
run Labview on a dedicated core and with the highest priority to 
hopefully cope with the real-time demands. Of course there is no guaranties.

Kim

