Message-ID: <4B71684B.4020307@domain.hid>
Date: Tue, 09 Feb 2010 14:51:07 +0100
From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
MIME-Version: 1.0
References: <4B71666A.6040508@domain.hid>
	<4B716732.3040306@domain.hid>
In-Reply-To: <4B716732.3040306@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Xenomai FAILED to register object
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

Thank
I just realized my mistake, I must be very tired

Gilles Chanteperdrix a écrit :
> Alexandre Coffignal wrote:
>   
>> Hi all,
>>
>> I use xenomai to port PSOS application, so I am using xenomai PSOS skin,
>> but i want to use xenomai pthread.
>>
>> My question is do you know if i can use psos skin and posix skin in the
>> same time?
>>
>> I already test it without success : when I load my prog, I have this
>> message :
>>     Xenomai pSOS skin init: t_shadow() failed, status -17
>>
>> and this message in dmess
>>     Xenomai: FAILED to register object MAIN (unknown type), status -17
>>     
>
> Because the main thread is already shadowed by the posix skin. It is
> already a xenomai task.
>
>   


-- 
Alexandre COFFIGNAL, Chef de Projet
Email: alexandre.coffignal@domain.hid
<mailto:alexandre.coffignal@domain.hid>
------------------------------------
CénoSYS <http://www.cenosys.com>
10, Rue Xavier Bichat
F-72000 Le MANS
Tel: +33(0) 243 511 797
web : http://www.cenosys.com
------------------------------------
CONFIDENTIALITE : Ce message électronique et tous les fichiers attachés
qu'il contient sont confidentiels et destinés exclusivement à l'usage de
la personne à laquelle ils sont adressés. Si vous avez reçu ce message
par erreur, merci de le retourner immédiatement a son émetteur sans en
conserver de copie.

CONFIDENTIALITY : This e-mail and any attachments are confidential and
may also be privileged. If you are not the named recipient, please
notify the sender immediately and do not disclose the contents to an
other person, use it for any purpose, or store or copy the information
in any medium.

