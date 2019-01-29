Subject: Re: Help on porting lwIP to Xenomai (Beaglebone Black, AM335X)
References: <acee54530584479b865ccefdbe3b0913@stud.uni-stuttgart.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8820d79c-1b53-f663-ab1a-874211e54ecf@siemens.com>
Date: Tue, 29 Jan 2019 15:40:35 +0100
MIME-Version: 1.0
In-Reply-To: <acee54530584479b865ccefdbe3b0913@stud.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Baur, Elias" <st153286@stud.uni-stuttgart.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 29.01.19 10:57, Baur, Elias via Xenomai wrote:
> Hello everyone,
> 
> I am new to lwIP and did a lot of research the last couple of days. My goal ist to do real time networking between wire-connected Beagleboards. Therefore, we have been setting up a Xenomai Co-Kernel on the boards. To actually send and receive UDP-packets, we want to use lwIP instead of RTnet, because we are already using it on other boards.

This doesn't sound like a strong argument. You should better look for hard 
facts, what benefits (or downsides) an lwIP stack would have. Then it is more 
realistic to weigh estimated efforts on both sides against benefits.

Also, who should be the low-level driver provider in your lwIP setup? Do you 
plan to write one from scratch?

Jan

> 
> I have found out that TI has already ported lwIP on its CPU in its Starterware: http://processors.wiki.ti.com/index.php/StarterWare_CPSW_Port_lwIP Now I am wondering whether it is possible to adapt this for Xenomai? Does anyone have experience on that?
> 
> Thank you very much!
> Best, Eloa
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

