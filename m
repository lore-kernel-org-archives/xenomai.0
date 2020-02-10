Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
 <0281e4a5-a2b2-bac5-1e30-ea2bb85f3d8d@siemens.com>
 <373cc865d6c34dda997ac6745bae99cd@RCDC-MAIL09.corp.diehl.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9cc5a0de-1db9-e46f-7aa8-30e41b1ac926@siemens.com>
Date: Mon, 10 Feb 2020 15:40:20 +0100
MIME-Version: 1.0
In-Reply-To: <373cc865d6c34dda997ac6745bae99cd@RCDC-MAIL09.corp.diehl.com>
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
To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.02.20 15:20, Carsten EHRMANN wrote:
> Hi Jan,
> 
> do I have to include the xeno-config file? I just configured it with "xeno-config --skin=native".

You can use your own hard-coded switches, provided you know what you are 
doing. Otherwise, picking them up during the build from xeno-config is 
recommended. It's enough to do it once during make startup.

> 
> I use a project file where includes are defined, see below:
> 
> unix {
> TEMPLATE = app
> } else {
> TEMPLATE = vcapp
> }
> CONFIG -= qt
> CONFIG += debug_and_release warn_on exceptions rtti
> Debug {
>      TARGET = CSRTDaemon
>      CONFIG += console
>      OBJECTS_DIR = ../tmp/obj/CSRTDaemon/debug
>      DESTDIR = ../lib/CSRTDaemon
>      DLLDESTDIR = ../dll/CSRTDaemon
>      SCOPE=debug
>      unix {
>          QMAKE_CXXFLAGS +=
>          QMAKE_CFLAGS +=
>          QMAKE_LFLAGS +=
>      } else {
>          QMAKE_POST_LINK = COPY /Y ../lib/CSRTDaemon/*.pdb ../dll/CSRTDaemon/
>      }
> } else {
>      TARGET = CSRTDaemon
>      OBJECTS_DIR = ../tmp/obj/CSRTDaemon/release
>      DESTDIR = ../lib/CSRTDaemon
>      DLLDESTDIR = ../dll/CSRTDaemon
>      DEFINES += QT_NO_DEBUG_OUTPUT NDEBUG
>      SCOPE=release
> }
> 
> 
> QMAKE_LIBDIR += /usr/xenomai/lib
> INCLUDEPATH += /usr/xenomai/include
> 

Again, what matters is what is passed to the individual gcc invocation. 
Check that. Otherwise, again, please send a reproduction case. We can't 
debug your local setup remotely.

Jan

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
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Monday, February 10, 2020 2:23 PM
> To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>; xenomai@xenomai.org
> Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
> 
> On 10.02.20 13:03, Carsten EHRMANN via Xenomai wrote:
>> Hello,
>>
>>
>> Because of new PC hardware I have to use debain 9 and Xenomai 3.
>> Xenomai is running on the system, I run the testsuite scripts. I found a migration document on xenomai.org and changed the includepaths and so on in my sourcecode. But now when I want to compile the code I got this error In file included from ./CSRTPosixQue.h:20:0,
>>                from ./CSRTTask.h:20,
>>                from main.cpp:26:
>> /usr/xenomai/include/trank/native/task.h: In function 'int rt_task_notify(RT_TASK*, rt_sigset_t)':
>> /usr/xenomai/include/trank/native/task.h:41:64: error: 'trank_warning'
>> was not declared in this scope trank_warning("in-kernel native API is
>> gone, rebase over RTDM");
>>
>> But this "trank_warning" is defined in trank.h which is included
>>
> 
> Where you using xeno-config to obtain paths and other compiler switches?
> If not, please compare your settings. If yes, a simple test case would be nice. But it can't be very simple because
> 
> #include <native/task.h>
> int main() {}
> 
> compiles via "gcc $(xeno-config --skin native --cflags) ..."
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

