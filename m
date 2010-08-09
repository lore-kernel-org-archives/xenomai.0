Date: Tue, 10 Aug 2010 00:13:12 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100809221312.GB3876@domain.hid>
References: <CB64A448250ADE40A2D9459AEB556D5E0274D4FBBF@NIHMLBX15.nih.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CB64A448250ADE40A2D9459AEB556D5E0274D4FBBF@NIHMLBX15.nih.gov>
Subject: Re: [Xenomai-help] Use of counter for quadratic encoder in NI
 PCI-6229 board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Kim, Jonghyun (NIH/CC) [F]" <jonghyun.kim@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Kim, Jonghyun (NIH/CC) [F] wrote:
> OS : Debian 5.0.4 + Xenomai 2.5.2
> HW : NI PCI-6229
> 
> 
> Hi.
> I have a question on the use of counter in NI PCI-6229 board.
> 
> Thanks to analogy, I can use the functions of AI and AO using NI PCI-6229.
> But, I failed to use its counter for quadratic encoder.
> 
> I think it may work, but it is hard for me because I don't have any verified example.
> 
> Recently, I tried the following code to set the counter up for quadratic encoder:
> ---------------------------------------------------------------------------------------------------
> a4l_desc_t dsc = {.sbdata = NULL };
> a4l_insn_t config;
> unsigned int data[4];
> 
> a4l_open(&dsc, filename);
> dsc.sbdata = malloc(dsc.sbsize);
> a4l_fill_desc(&dsc);
> 
> config.type = A4L_INSN_CONFIG;
> config.idx_subd = 10;  // this is correct. I checked it
> data[0] = A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER;
> data[1] = 0; // X1, X2, X4
> data[2] = 0; // indexphase HH, LH, ...
> data[3] = 0; // indexreset
> config.data = data;
> config.data_size = 4*sizeof(unsigned int);
> 
> a4l_snd_insn(&dsc, &config);
> ----------------------------------------------------------------------------------------------------
> 
> However, the last a4l_snd_insn() returned error code, -22.
> 

Are you still using the subdevice index 10 ? How did you check that it
was correct? With my NI6221 board, the GCPT counter seems to be
located at index 11 and the subdevice index are static (unless there
is a bug).

# cat /proc/analogy/00-analogy_ni_pcimio                                        
--  Subdevices --                                                               
                                                                                
| idx | type                                                                    
|  00 | Analog input subdevice                                                  
|  01 | Analog output subdevice                                                 
|  02 | Digital input/output subdevice                                          
|  03 | Unused subdevice                                                        
|  04 | Unused subdevice                                                        
|  05 | Calibration subdevice                                                   
|  06 | Memory subdevice                                                        
|  07 | Digital input/output subdevice                                          
|  08 | Unused subdevice                                                        
|  09 | Serial subdevice                                                        
|  10 | Unused subdevice                                                        
|  11 | Counter subdevice                                                       
|  12 | Counter subdevice                                                       
|  13 | Counter subdevice    

> 
> Could you give me the verified sample code for quadratic encoder using NI PCI-6229 board?
> Or plz help me to use my encoder :(
> 
> Many thanks in advance.
> 
> Jonghyun
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Alexis.

