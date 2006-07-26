Message-ID: <44C78533.3020507@domain.hid>
Date: Wed, 26 Jul 2006 12:07:31 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How can I now when it will be next periodic task
	release point?
References: <200607251735.35500.lbocseg@domain.hid>
	<44C6865A.9010403@domain.hid>
In-Reply-To: <44C6865A.9010403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

Hannes Mayer escreveu:
> Ciao Rodrigo!
> ...
>
> Just trying to understand your problem:
> If you wanna capture a image every 300ms, the processing must not take
> longer than 300ms, otherwise you have some kind over overrun (?)
> So you capture an image, process it within 300ms and then capture
> the next one, right ?
The processing takes something like 20 ms, but I don't need to process 
at a higher rate than 300 ms...
>
> OK, wait a sec. I think I got it.
> I guess your problem is having both capturing and processing in one 
> loop ?
> Why not make 2 threads, one for capturing, and one for processing ?
Because I don't really need it... It is much simpler the way I'm 
doing... Let me explain better what happen... When I make a request to 
capture an image to the framegrabber, the process will start on the 
beggining of the next field. Each field takes about 17 ms to complete 
for a NTSC camera... I would not like to wait for the field end, so I 
want to request a frame 33 ms before next release point so that a new 
image will be already present for sure on next release point. I could do 
some better design for better precision but I really don't need it. The 
process is far too simple... I can do it right now. The question is that 
I would like a cleaner way to do it. I would like to make clear that I 
want to request a frame 33 ms before next release point...
> I may be totally wrong - just trying to understand and maybe help :-)
I think I've explained it better now, didn't I?
> Best regards,
> Hannes.
>
> PS.: Why do all replies go only to the sender ? This hasn't been that
> way in the (far) past, right ?
As far as I recall it was always like that, unfortunately. I also would 
like that the reply-to was to the list. Sometimes I forget to press the 
reply-to-all button on my e-mail client...

Thank you Hannes,
Best Regards

Rodrigo.


		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



