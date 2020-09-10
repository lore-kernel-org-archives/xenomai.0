From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Subject: fortify_source and syscall wrapping
Message-ID: <8f108aa8-9c16-dd4c-9808-2020c61465b9@rsi-elektrotechnik.de>
Date: Thu, 10 Sep 2020 12:37:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi all,

I just had a long debugging session and wanted to comment the result here
on the list.

When using -D_FORTIFY_SOURCE=2 the first ioctl() after open() suddenly
failed. This is due to an inline function "open()" (in bits/fcntl2.h),
that will analyse the call arguments and forward the function call
accordingly. When the second argument is not a compile-time constant,
then the call is forwarded to "__open_2()" instead of "__open_alias()".

So when you write:

open("/dev/rtdm/rtser0", O_RDWR);

then __cobalt_open() will be called. But when you use a function like
this:

int my_function(int mode) {
    return open("/dev/rtdm/rtser0", mode);
}

then __open_2() will be called. The consequence is that the following
ioctl(RTSER_RTIOC_SET_CONFIG) fails, as the file descriptor was not
opened by __cobalt_open().

This is a nasty little difference. My solution was to write:

int my_function(int mode) {
    return __WRAP(open("/dev/rtdm/rtser0", mode));
}

Maybe this is just ancient history for you, but I had some "fun" to find
this.

Regards,
Jan


Mit freundlichen Grüßen

*Jan Leupold*
Entwicklung
Development
-- 
---------------------------------------------------------------------------
R-S-I Logo <https://www.rsi-elektrotechnik.de/>

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestraße 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de <https://www.rsi-elektrotechnik.de/>

Tel: +49 8444 9204-32
Fax: +49 8444 9204-50
leupold@rsi-elektrotechnik.de <mailto:leupold@rsi-elektrotechnik.de>
---------------------------------------------------------------------------

Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548



