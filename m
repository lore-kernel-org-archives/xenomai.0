Message-ID: <4AE7EA79.5070904@domain.hid>
Date: Tue, 27 Oct 2009 23:53:45 -0700
From: Jonas Buchli <jonas@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] analog output device with comedi/analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear all,

we are trying to get a National Instruments DA/AD card (NI PCIe 6259, 
see link below) working with comedi/analogy.

The drivers seem to be doing something, I can pull up the analog outputs 
to 10V (max voltage) using the example program cmd_write. So I think the 
issues I am having are stemming from not understanding and using the API 
correctly rather than driver issues (but I might be wrong).

Thus, I am trying to understand how to actually write a waveform to the 
analog output and am so far not very successful and the comedi doc seems 
a bit cryptic and scarce to me in this respect.

- Does anyone have example code how this is done?

- Is the correct procedure to issue first a command (comedi_snd_command) 
and then use the write command (comedi_sys_write) to achieve this?

- Interestingly the write command (comedy_sys_write) is not the one 
responsible for pulling up the output, it seems to already happen in the 
comedi_snd_command.

- My current approach was trying to modify the cmd_write example. Is 
this a good idea?

Any help and pointers would be greatly appreciated!

Thanks a lot and best regards
Jonas


PS:
Card being used NI PCIe 6259:
http://sine.ni.com/nips/cds/view/p/lang/en/nid/14128









