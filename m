Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
 <0281e4a5-a2b2-bac5-1e30-ea2bb85f3d8d@siemens.com>
 <373cc865d6c34dda997ac6745bae99cd@RCDC-MAIL09.corp.diehl.com>
 <9cc5a0de-1db9-e46f-7aa8-30e41b1ac926@siemens.com>
 <f92ca27d1ba34380b47c0c451da4f61b@RCDC-MAIL09.corp.diehl.com>
 <925e50f4-8395-2a15-3654-73ea1f241f1c@siemens.com>
 <b4806aec7c5746bc83fa897b09ce7ab1@RCDC-MAIL09.corp.diehl.com>
 <d36eca04d68b4434bde75d9cfa8c1418@RCDC-MAIL09.corp.diehl.com>
 <f7fc8190-afe3-872e-d7aa-dcabcd576a77@siemens.com>
 <ee2bea74fc5b40af8fbc9cff17c9bd78@RCDC-MAIL09.corp.diehl.com>
 <CAFLxGvyxyfU0_F+mqymZg1d+X_Rzw9=LoZQAXuF5J8skR8n2Xg@mail.gmail.com>
 <6b399d7610174bb585e2fb439d735402@RCDC-MAIL09.corp.diehl.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8f7a0986-8549-fd2c-f49b-65595f9a1d16@siemens.com>
Date: Tue, 3 Mar 2020 17:59:51 +0100
MIME-Version: 1.0
In-Reply-To: <6b399d7610174bb585e2fb439d735402@RCDC-MAIL09.corp.diehl.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>, Richard Weinberger <richard.weinberger@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.03.20 14:02, Carsten EHRMANN wrote:
> Thanks, I added --posix to
> 
> shell  $$XENO_CONFIG --skin=native --ldflags --posix
> 
> so I have this call:
> 
> g++ -c -pipe -I/usr/xenomai/include/trank/posix -I/usr/xenomai/include/trank -D__XENO_COMPAT__ -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -m32 -O2 -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__ -I/usr/xenomai/include/alchemy -D__COBALT_WRAP__ -O2 -Wall -W -fPIC -DQT_NO_DEBUG_OUTPUT -DNDEBUG -I. -I/usr/xenomai/include -I. -I../inc -I../inc/CSRTDaemon/ -I../inc/CSBase -I../inc/CSPosixAbstraction -I../inc/CSProxies -I../inc/CSApplication -I../inc/CSApplication/telegrams -I../inc/CSApplication/tasks -I../inc/CSApplication/ques -I../inc/CSApplication/events -I/usr/lib/i386-linux-gnu/qt5/mkspecs/linux-g++ -o ../tmp/obj/CSRTDaemon/release/CSRTPosixQue.o CSRTPosixQue.cpp
> 
> 
> 
> but I still have the same error.
> 

Please read our suggestions carefully: Go to your kernel build folder, 
invoke "make menuconfig" and check under Xenomai settings if RTIPC as 
well as XDDP are enable. If not, change that, rebuild, install, profit.

Jan

> 
> Carsten
> 
> 
> 
> _________________________________________________________________________________________________________
> Bitte überlegen Sie, ob Sie diese Nachricht wirklich ausdrucken müssen/ before printing, think about environmental responsibility.
> Diehl Metering GmbH, Industriestraße 13, 91522 Ansbach
> Telefon + 49 981 1806 0, Telefax +49 981 1806 615
> Sitz der Gesellschaft: Ansbach, Registergericht: Ansbach HRB 69
> Geschäftsführer: Dr. Christof Bosbach (Sprecher), Thomas Gastner, Jean-François Marguet
> Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte Informationen. Informieren Sie uns bitte, wenn Sie diese E-Mail fälschlicherweise erhalten haben. Bitte löschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Änderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
> The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
> Informationen zum Datenschutz finden Sie auf unserer Homepage.
> https://www.diehl.com/metering/de/diehl-metering/data-protection
> Information about data protection can be found on our homepage.
> https://www.diehl.com/metering/en/diehl-metering/data-protection
> 
> 
> -----Original Message-----
> From: Richard Weinberger <richard.weinberger@gmail.com>
> Sent: Tuesday, March 3, 2020 1:08 PM
> To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>; xenomai@xenomai.org
> Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
> 
> On Tue, Mar 3, 2020 at 1:03 PM Carsten EHRMANN via Xenomai <xenomai@xenomai.org> wrote:
>>
>> Hi Jan,
>>
>> I don't have one of the files
>>
>> - /usr/src/linux-4.9.146/include/config/xeno/drivers/rtipc/xddp.h
>>
>> - /lib/modules/4.9.146/kernel/drivers/xenomai /ipc/xeno_rtipc.ko
>>
>>
>> Where do I get them? Do they have to be installed when building the kernel?
> 
> Did you enable CONFIG_XENO_DRIVERS_RTIPC_XDDP in your kernel.
> 
> --
> Thanks,
> //richard
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

