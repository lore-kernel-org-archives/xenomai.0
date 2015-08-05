Message-ID: <55C19B7E.9000603@gatech.edu>
Date: Wed, 05 Aug 2015 01:13:34 -0400
From: "Yogi A. Patel" <yapatel@gatech.edu>
MIME-Version: 1.0
References: <55C17C8E.5000909@gatech.edu> <55C19859.6040508@xenomai.org>
In-Reply-To: <55C19859.6040508@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/05/2015 01:00 AM, Jorge Ramirez Ortiz wrote:
> On 08/04/2015 11:01 PM, Yogi A. Patel wrote:
>> Hi -
>>
>> I am migrating a xenomai 2.5.4 application to the cobalt core. I have xenomai
>> 3.0-rc5 installed with 3.18.12.
>>
>> I have a NI PCI 6250 card that is attached via analogy_config. I can
>> successfully run the insn_read command that is installed with the user space
>> support by running:
>>
>> sudo ./insn_read -d analogy0 -c 3 -R 0 --verbose
>>
>> This prints out a set of values close to what I am expecting (5V)
>>
>> I then attempt to use the analogy calibration feature added to Xenomai 3 by
>> running:
>>
>> sudo ./analogy_calibrate --device=analogy0 --output=calvals.bin
>>
>> This prints out the following:
>>
>>     0"000.079| calibration output: calvals.binls
>>     0"004.427| calibrating device: analogy_ni_pcimio
>>     0"255.934| Polynomial :
>>     0"255.972|     order =  3
>>     0"255.995|     expansion origin =  32767.000000
>>     0"256.026|     order  0  coefficient =  32867.5
>>     0"256.051|     order  1  coefficient =  0.949174
> ...
>> NOTE: there appears to be a print bug above (0"283.294| Calibrating AI: �m)
> apply the following:
>
> [jramirez@calypso ~ (master *)]$ git diff calibration_ni_m.c
> diff --git a/utils/analogy/calibration_ni_m.c b/utils/analogy/calibration_ni_m.c
> index c72a44d..6f9be6f 100644
> --- a/utils/analogy/calibration_ni_m.c
> +++ b/utils/analogy/calibration_ni_m.c
> @@ -973,7 +973,7 @@ static int ni_m_calibrate_ai(void)
>           * calibrate low, medium and high gain ranges
>           */
>          for (i = 0; i < ARRAY_LEN(cal_info); i++) {
> -               __debug("Calibrating AI: %s \n", cal_info[i]);
> +               __debug("Calibrating AI: %s \n", cal_info[i].message);
>
>                  if (cal_info[i].range >= 0)
>                          goto calibrate;
>
>
>
>>> Has anyone successfully used the calibration feature?
> it seemed to work ok when I wrote the code some time ago on the 6220 I think it was.
> Please could you post the contents of the calibration file?
The calibration file output is:

[platform]
driver_name = analogy_ni_pcimio;
board_name = pci-6250;

[analog_input]
index = 0;
elements = 7;
[analog_input_0]
channel = -1;
range = 0;
expansion_origin = 6.95327e-310;
nbcoeff= 4;
coeff_0 = 6.36599e-314;
coeff_1 = 6.95327e-310;
coeff_2 = 4.94066e-324;
coeff_3 = 6.95187e-310;
[analog_input_1]
channel = -1;
range = 1;
expansion_origin = 32767;
nbcoeff= 4;
coeff_0 = -0.000597716;
coeff_1 = 0.000162699;
coeff_2 = -2.5516e-11;
coeff_3 = -1.15365e-15;
[analog_input_2]
channel = -1;
range = 2;
expansion_origin = 32767;
nbcoeff= 4;
coeff_0 = -0.000204136;
coeff_1 = 6.4913e-05;
coeff_2 = -1.01803e-11;
coeff_3 = -4.60278e-16;
[analog_input_3]
channel = -1;
range = 3;
expansion_origin = 32767;
nbcoeff= 4;
coeff_0 = -7.99442e-05;
coeff_1 = 3.25526e-05;
coeff_2 = -5.10522e-12;
coeff_3 = -2.3082e-16;
[analog_input_4]
channel = -1;
range = 4;
expansion_origin = 32767;
nbcoeff= 4;
coeff_0 = -1.47307e-05;
coeff_1 = 1.62562e-05;
coeff_2 = -2.54945e-12;
coeff_3 = -1.15267e-16;
[analog_input_5]
channel = -1;
range = 5;
expansion_origin = 32767;
nbcoeff= 4;
coeff_0 = 2.13154e-05;
coeff_1 = 6.51906e-06;
coeff_2 = -1.02238e-12;
coeff_3 = -4.62246e-17;
[analog_input_6]
channel = -1;
range = 6;
expansion_origin = 32767;
nbcoeff= 4;
coeff_0 = 3.44007e-05;
coeff_1 = 3.253e-06;
coeff_2 = -5.10168e-13;
coeff_3 = -2.3066e-17;

