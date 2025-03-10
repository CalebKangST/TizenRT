/****************************************************************************
 *
 * Copyright 2020 Samsung Electronics All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ****************************************************************************/
/****************************************************************************
 *
 *   Copyright (C) 2020 Gregory Nutt. All rights reserved.
 *   Author: Gregory Nutt <gnutt@nuttx.org>
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name NuttX nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/

OUTPUT_ARCH(arm)
ENTRY(app_start)

MEMORY
{
	IROM (rx) : 			ORIGIN = 0x10100000, LENGTH = 0x1010A000 - 0x10100000	/* ROM: 40k */
	IROM_NS (rx) : 			ORIGIN = 0x1010A000, LENGTH = 0x10140000 - 0x1010A000	/* ROM: 216k */
	DROM_NS (rx) : 			ORIGIN = 0x101C0000, LENGTH = 0x101D4000 - 0x101C0000	/* ROM: 80k */
	DROM (rx) : 			ORIGIN = 0x101D4000, LENGTH = 0x101D8000 - 0x101D4000	/* ROM: 16k */
	ROMBSS_RAM_COM (rw)  : 		ORIGIN = 0x10000000, LENGTH = 0x10001000 - 0x10000000	/* ROM BSS COMMON(S & NS both used) RAM: 4K */
	ROMBSS_RAM_NS (rw)  : 		ORIGIN = 0x10001000, LENGTH = 0x10002000 - 0x10001000	/* ROM BSS NS RAM: 4K */
	RSVD_RAM_NS (rw)  : 		ORIGIN = 0x10002000, LENGTH = 0x10004000 - 0x10002000	/* RSVD RAM: 8K */
	MSP_RAM_NS (rw)  : 		ORIGIN = 0x10004000, LENGTH = 0x10005000 - 0x10004000	/* MSP_NS RAM: 4K */

	BD_RAM_NS (rwx)  : 		ORIGIN = 0x10005000, LENGTH = 0x10077000 - 0x10005000	/* MAIN RAM NS: 456K */
	BD_RAM_S (rwx)  : 		ORIGIN = 0x10077000, LENGTH = 0x1007B000 - 0x10077000	/* MAIN RAM S: 16K */
	BD_RAM_NSC (rwx)  : 		ORIGIN = 0x1007B000, LENGTH = 0x1007C000 - 0x1007B000	/* MAIN RAM NSC: 4K */
	ROMBSS_RAM_S (rwx)  : 		ORIGIN = 0x1007C000, LENGTH = 0x1007D000 - 0x1007C000	/* ROM BSS RAM S: 4K */
	BOOTLOADER_RAM_S (rwx)  : 	ORIGIN = 0x1007D000, LENGTH = 0x1007F000 - 0x1007D000	/* BOOT Loader RAM: 8K */
	MSP_RAM_S (rwx)  : 		ORIGIN = 0x1007F000, LENGTH = 0x10080000 - 0x1007F000	/* MSP_S RAM: 4k */
	EXTENTION_SRAM (rwx)  : 		ORIGIN = 0x100E0000, LENGTH = 0x10100000 - 0x100E0000	/* EXTENTION SRAM: 128k */

	PSRAM_NS (rwx)  : 		ORIGIN = 0x02000000, LENGTH = 0x02300000 - 0x02000000	/* PSRAM_NS: 3M */
	PSRAM_S (rwx)	:		ORIGIN = 0x02300000, LENGTH = 0x02400000 - 0x02300000	/* PSRAM_S: 1M */

	/* Flash */
	KM0_BOOT (rx)  :		ORIGIN = 0x08000000+0x20, LENGTH = 0x04000-0x20	/* XIPBOOT: 16k, 32 Bytes resvd for header*/
	BACKUP (r) :			ORIGIN = 0x08080000, LENGTH = 0x1000	/* BACKUP: 4K system data in flash */
	XIPSYS (r) :			ORIGIN = 0x08081000, LENGTH = 0x1000	/* XIPSYS: 4K system data in flash */
	KM4_BOOT (rx)  :		ORIGIN = 0x08004000+0x20, LENGTH = 0x02000-0x20	/* XIPBOOT: 8k, 32 Bytes resvd for header*/
	KM0_IMG2 (rx)  : 		ORIGIN = 0x0C000000+0x20, LENGTH = 0x02000000-0x20	/* KM0_IMG2: 32MB, 32 Bytes resvd for header, virtual address */
	KM4_IMG2 (rx)  : 		ORIGIN = 0x0E000000+0x20, LENGTH = 0x02000000-0x20	/* KM4_IMG2 OTA1: 32MB, 32 Bytes resvd for header,  virtual address */
	BTRACE (rx) :			ORIGIN = 0x00800000, LENGTH = 0x00C00000 -0x00800000	/* Bluetooth Trace */
	
	/* KM0 RAM*/
	KM0_SRAM (rwx)  : 		ORIGIN = 0x00080000, LENGTH = 0x00090000 - 0x00080000	/* KM0 SRAM: 64k */
	RETENTION_RAM (rwx)  : 		ORIGIN = 0x000C0000, LENGTH = 0x000C0400 - 0x000C0000	/* KM0 Retention SRAM: 1k */
}

SECTIONS
{
	.rom.text : { } > IROM_NS
	.rom.rodata : { } > DROM_NS
	.hal.rom.bss : { } > ROMBSS_RAM_COM
	.hal.ns_rom.bss : { } > ROMBSS_RAM_NS

	/* image2: normal image start */
	.ram_image2.entry :
	{
		__ram_image2_text_start__ = .;
		__image2_entry_func__ = .;
		KEEP(*(SORT(.image2.entry.data*)))

		__image2_validate_code__ = .;
		KEEP(*(.image2.validate.rodata*)) 

	} > BD_RAM_NS

	.ram_image2.text :
	{
		__ram_text_start__ = .;
		_stext_ram = ABSOLUTE(.);
		*(.image2.ram.text*)
		*(.image2.net.ram.text*)
		/*os*/
		*os_start.o (.text*)
		*osdep_service.o (.text*)
		*tizenrt_service.o (.text*)
		/*irq(svcall)*/
		/**irq_initialize.o (.text*)*/
		*amebad_irq.o (.text*)
		*up_exception.o (.text*)
		*up_svcall.o (.text*)
		*up_switchcontext.o (.text*)
		*up_copyfullstate.o (.text*)
		*up_fullcontextrestore.o (.text*)
		*up_doirq.o (.text*)
		*irq_dispatch.o (.text*)
		/*scheduler(for semphr)*/
		*sched_addreadytorun.o (.text*)
		*sched_addblocked.o (.text*)
		*sched_addprioritized.o (.text*)
		*sched_removereadytorun.o (.text*)
		*sched_removeblocked.o (.text*)
		*sched_mergepending.o (.text*)
		*up_blocktask.o (.text*)
		*up_unblocktask.o (.text*)
		/*semphr*/
		*sem_wait.o (.text*)
		*sem_waitirq.o (.text*)
		*sem_trywait.o (.text*)
		*sem_tickwait.o (.text*)
		*sem_timedwait.o (.text*)
		*sem_post.o (.text*)
		/*lwip*/
		*tcp_in.o (.text*)
		*tcp_out.o (.text*)
		*def.o (.text*)
		*igmp.o (.text*)
		*pbuf.o (.text*)
		*inet_chksum.o (.text*)
		*api_msg.o (.text*)
		*netbuf.o (.text*)
		*sys_arch.o (.text*)
		*ethernetif_tizenrt.o (.text*)
		*lwip_intf_tizenrt.o (.text*)
		*timeout.o (.text*)
		*raw.o (.text*)
		*mem.o (.text*)
		*memp.o (.text*)
		*netif.o (.text*)
		*ip.o (.text*)
		*ip4.o (.text*)
		*ip4_addr.o (.text*)
		*ip4_frag.o (.text*)
		*ip6.o (.text*)
		*ip6_addr.o (.text*)
		*ip6_frag.o (.text*)
		*tcp.o (.text*)
		*udp.o (.text*)
		*socket.o (.text*)
		*bsd_socket_api.o (.text*)
		*tcpip.o (.text*)
		*ethernet.o (.text*)
		*etharp.o (.text*)
		*ethip6.o (.text*)
		*netdb.o (.text*)
		*api_lib.o (.text*)
		*netifapi.o (.text*)
		/*iperf*/
		*iperf_server_api.o (.text*)
		*iperf_api.o (.text*)
		*iperf_tcp.o (.text*)
		*iperf_net.o (.text*)
		/*fs*/
		/**fs_read.o (.text*)
		*fs_select.o (.text*)
		*fs_poll.o (.text*)*/
		/*others*/
		*lib_vikmemcpy.o (.text*)
		*dq_rem.o (.text*)
		*dq_addlast.o (.text*)
		_etext_ram = ABSOLUTE(.);
		__ram_text_end__ = .;
	} > BD_RAM_NS

	_eronly = ABSOLUTE(.);

	.ram_image2.data : 
	{
		_sdata = ABSOLUTE(.);
		__data_start__ = .;
		*(.data*)
		__data_end__ = .;
		_edata = ABSOLUTE(.);
		__ram_image2_text_end__ = .;
		. = ALIGN(16);	
	} > BD_RAM_NS

	.ram_image2.bss :
	{
		_sbss = ABSOLUTE(.);
		__bss_start__ = .;
		*(.bss*)
		*(COMMON)
		__bss_end__ = .;

	} > BD_RAM_NS

	.ram_image2.nocache.data :
	{
		. = ALIGN (32);
		__ram_nocache_start__ = .;
		*(.bdsram.data*)
		. = ALIGN (32);
		__ram_nocache_end__ = .;
	} > BD_RAM_NS

	.ram_heap.data : 
	{
		. = ALIGN (32);
		*(.bfsram.data*)
		end = .;
		_ebss = ABSOLUTE(.);
	} > BD_RAM_NS

	.xip_image2.text : 
	{
		__flash_text_start__ = .;
		_stext_flash = ABSOLUTE(.);

		*(.img2_custom_signature*)

		*(.text*)
	/*	*(.image2.net.ram.text*) */		
		*(.rodata*)

		/* Add This for C++ support */
		. = ALIGN(4);
		__preinit_array_start = .;
		KEEP(*(.preinit_array))
		__preinit_array_end = .;
		. = ALIGN(4);
		__init_array_start = .;
		_sinit = ABSOLUTE(.);
		KEEP(*(SORT(.init_array.*)))
		KEEP(*(.init_array))
		_einit = ABSOLUTE(.);
		__init_array_end = .;
		. = ALIGN(4);
		__fini_array_start = .;
		KEEP(*(SORT(.fini_array.*)))
		KEEP(*(.fini_array))
		__fini_array_end = .;	
		/*-----------------*/		

		. = ALIGN (4);
		__cmd_table_start__ = .;
		KEEP(*(.cmd.table.data*))
		__cmd_table_end__ = .;

		_etext_flash = ABSOLUTE(.);
		__flash_text_end__ = .;
	
		. = ALIGN (16);
	} > KM4_IMG2

	/* Add This for C++ support */
	.ARM.extab  : 
	{
		*(.ARM.extab* .gnu.linkonce.armextab.*) 

	} > KM4_IMG2

	.ARM.exidx :
	{
		__exidx_start = .;
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
		__exidx_end = .;
	} > KM4_IMG2
	/*-----------------*/

	.bluetooth_trace.text :
	{
		__btrace_start__ = .;
		*(.BTTRACE)
		__btrace_end__ = .;
	} > BTRACE

	/* PSRAM_NS image start */
	.psram_image2.text :
	{
		__psram_image2_text_start__ = .;
		*(.psram.text*)
		__psram_image2_text_end__ = .;
	} > PSRAM_NS

	.psram_image2.data : 
	{
		. = ALIGN (32);
		*(.psram.data*)
		. = ALIGN (32);
		*(.psram.rodata*)
	} > PSRAM_NS
  
	.psram_image2.bss :
	{
		. = ALIGN (32);
		__psram_bss_start__ = .;
		*(.psram.bss*)
		__psram_bss_end__ = .;
	} > PSRAM_NS

	.psram_heap.data : 
	{
		. = ALIGN (32);
		*(.psram.heap*)
	} > PSRAM_NS
	__StackLimit = ABSOLUTE(ORIGIN(BD_RAM_NS) + LENGTH(BD_RAM_NS));
	__PsramStackLimit = ABSOLUTE(ORIGIN(PSRAM_NS) + LENGTH(PSRAM_NS));
}
SECTIONS
{
    __rom_bss_start__ = 0x10000000;
    ConfigDebugClose = 0x10000000;
    ConfigDebugBuffer = 0x10000004;
    ConfigDebugBufferGet = 0x10000008;
    ConfigDebug = 0x1000000c;
    rand_first = 0x1000001c;
    rand_seed = 0x10000020;
    RBSS_UDELAY_DIV = 0x10000034;
    flash_init_para = 0x10000038;
    GDMA_Reg = 0x10000098;
    PortA_IrqHandler = 0x1000009c;
    PortA_IrqData = 0x1000011c;
    PortB_IrqHandler = 0x1000019c;
    PortB_IrqData = 0x1000021c;
    IPC_IrqHandler = 0x1000029c;
    IPC_IrqData = 0x1000031c;
    IS_FPGA_VERIF = 0x1000039c;
    crypto_engine = 0x100003a0;
    __rom_bss_end__ = 0x10000564;
    __rom_bss_start_ns__ = 0x10001000;
    NewVectorTable = 0x10001000;
    UserIrqFunTable = 0x10001140;
    UserIrqDataTable = 0x10001240;
    mpu_entry_register = 0x10001340;
    p_rom_ssl_ram_map = 0x10001348;
    rom_ssl_ram_map = 0x1000134c;
    __rom_bss_end_ns__ = 0x1000138c;
    __rom_bss_start_s__ = 0x1007c000;
    __ram_start_table_start__ = 0x1007d000;
    STACK_TOP = 0x1007effc;
    __vectors_table = 0x1010a000;
    Reset_Handler = 0x1010a101;
    NMI_Handler = 0x1010a111;
    HardFault_Handler = 0x1010a115;
    MemManage_Handler = 0x1010a119;
    BusFault_Handler = 0x1010a11d;
    UsageFault_Handler = 0x1010a121;
    SecureFault_Handler = 0x1010a125;
    DiagVSprintf = 0x1010a12d;
    DiagPrintf = 0x1010a3f5;
    DiagPrintfD = 0x1010a445;
    DiagSPrintf = 0x1010a471;
    DiagSnPrintf = 0x1010a49d;
    Rand = 0x1010a765;
    Rand_Arc4 = 0x1010a7f1;
    RandBytes_Get = 0x1010a825;
    io_assert_failed = 0x1010a871;
    BKUP_Write = 0x1010a891;
    BKUP_Read = 0x1010a8b5;
    BKUP_Set = 0x1010a8d5;
    BKUP_Clear = 0x1010a8fd;
    BOOT_Reason = 0x1010a929;
    DelayNop = 0x1010a939;
    DelayUs = 0x1010a949;
    DelayMs = 0x1010a995;
    EFUSEPowerSwitch = 0x1010a9a9;
    EFUSERead8 = 0x1010aa31;
    EFUSEWrite8 = 0x1010ab1d;
    EFUSE_PG_Packet = 0x1010ac21;
    EFUSE_LogicalMap_Read = 0x1010ae99;
    EFUSE_LogicalMap_Write = 0x1010afad;
    FLASH_RxData = 0x1010b195;
    FLASH_TxCmd = 0x1010b29d;
    FLASH_SW_CS_Control = 0x1010b329;
    FLASH_SetSpiMode = 0x1010b37d;
    FLASH_RxCmd = 0x1010b415;
    FLASH_WaitBusy = 0x1010b479;
    FLASH_WriteEn = 0x1010b4f9;
    FLASH_TxData256B = 0x1010b51d;
    FLASH_TxData12B = 0x1010b60d;
    FLASH_SetStatus = 0x1010b6ed;
    FLASH_Erase = 0x1010b70d;
    FLASH_DeepPowerDown = 0x1010b7b9;
    FLASH_SetStatusBits = 0x1010b809;
    FLASH_StructInit_Micron = 0x1010b8dd;
    FLASH_StructInit_MXIC = 0x1010b98d;
    FLASH_StructInit_GD = 0x1010ba39;
    FLASH_StructInit = 0x1010baed;
    FLASH_Init = 0x1010bba1;
    GDMA_StructInit = 0x1010bc25;
    GDMA_SetLLP = 0x1010bc45;
    GDMA_ClearINTPendingBit = 0x1010bcd9;
    GDMA_ClearINT = 0x1010bda5;
    GDMA_INTConfig = 0x1010be75;
    GDMA_Cmd = 0x1010bf91;
    GDMA_Init = 0x1010bff9;
    GDMA_ChCleanAutoReload = 0x1010c14d;
    GDMA_SetSrcAddr = 0x1010c1d1;
    GDMA_GetSrcAddr = 0x1010c221;
    GDMA_GetDstAddr = 0x1010c26d;
    GDMA_SetDstAddr = 0x1010c2b9;
    GDMA_SetBlkSize = 0x1010c309;
    GDMA_GetBlkSize = 0x1010c369;
    GDMA_ChnlRegister = 0x1010c3b9;
    GDMA_ChnlUnRegister = 0x1010c401;
    GDMA_ChnlAlloc = 0x1010c43d;
    GDMA_ChnlFree = 0x1010c4d9;
    GDMA_GetIrqNum = 0x1010c565;
    GPIO_INTMode = 0x1010c5a9;
    GPIO_INTConfig = 0x1010c641;
    GPIO_INTHandler = 0x1010c679;
    GPIO_Direction = 0x1010c721;
    GPIO_Init = 0x1010c755;
    GPIO_DeInit = 0x1010c7e1;
    GPIO_ReadDataBit = 0x1010c84d;
    GPIO_WriteBit = 0x1010c871;
    GPIO_PortDirection = 0x1010c8a1;
    GPIO_PortRead = 0x1010c8c5;
    GPIO_PortWrite = 0x1010c8d5;
    GPIO_UserRegIrq = 0x1010c8ed;
    IPC_INTConfig = 0x1010c925;
    IPC_IERSet = 0x1010c939;
    IPC_IERGet = 0x1010c93d;
    IPC_INTRequest = 0x1010c941;
    IPC_INTClear = 0x1010c94d;
    IPC_INTGet = 0x1010c959;
    IPC_CPUID = 0x1010c95d;
    IPC_SEMGet = 0x1010c969;
    IPC_SEMFree = 0x1010c9b9;
    IPC_INTHandler = 0x1010ca21;
    IPC_INTUserHandler = 0x1010ca61;
    LOGUART_StructInit = 0x1010ca9d;
    LOGUART_Init = 0x1010cab5;
    LOGUART_PutChar = 0x1010caf5;
    LOGUART_GetChar = 0x1010cb29;
    LOGUART_Readable = 0x1010cb45;
    LOGUART_GetIMR = 0x1010cb59;
    LOGUART_SetIMR = 0x1010cb65;
    LOGUART_WaitBusy = 0x1010cb71;
    LOGUART_SetBaud = 0x1010cb91;
    mpu_enable = 0x1010cbd5;
    mpu_disable = 0x1010cbed;
    mpu_init = 0x1010cc01;
    mpu_set_mem_attr = 0x1010cc3d;
    mpu_region_cfg = 0x1010ccb1;
    mpu_entry_free = 0x1010cdb5;
    mpu_entry_alloc = 0x1010cdc1;
    RSIP_Cmd = 0x1010cde9;
    RSIP_OTF_init = 0x1010ce05;
    RSIP_OTF_Cmd = 0x1010ce6d;
    RSIP_OTF_Mask = 0x1010ce81;
    RSIP_KEY_Request = 0x1010cec9;
    RSIP_MMU_Config = 0x1010cf0d;
    RSIP_MMU_Cmd = 0x1010cf31;
    PAD_DrvStrength = 0x1010cf51;
    PAD_PullCtrl = 0x1010cf6d;
    PAD_CMD = 0x1010cf99;
    Pinmux_Config = 0x1010cfb9;
    Pinmux_ConfigGet = 0x1010cfd9;
    Pinmux_UartLogCtrl = 0x1010cfe9;
    Pinmux_SpicCtrl = 0x1010d03d;
    simulation_bit_index = 0x1010d181;
    simulation_stage_set = 0x1010d199;
    SYSTIMER_Init = 0x1010d1c5;
    SYSTIMER_TickGet = 0x1010d215;
    SYSTIMER_GetPassTime = 0x1010d225;
    RTIM_TimeBaseStructInit = 0x1010d255;
    RTIM_Cmd = 0x1010d26d;
    RTIM_GetCount = 0x1010d2f5;
    RTIM_INTConfig = 0x1010d361;
    RTIM_INTClear = 0x1010d3f1;
    RTIM_TimeBaseInit = 0x1010d45d;
    RTIM_DeInit = 0x1010d595;
    RTIM_INTClearPendingBit = 0x1010d611;
    RTIM_GetFlagStatus = 0x1010d685;
    RTIM_GetINTStatus = 0x1010d75d;
    UART_DeInit = 0x1010d83d;
    UART_StructInit = 0x1010d845;
    UART_BaudParaGetFull = 0x1010d861;
    UART_BaudParaGet = 0x1010d899;
    UART_SetBaud = 0x1010d8bd;
    UART_SetBaudExt = 0x1010d955;
    UART_SetRxLevel = 0x1010d9cd;
    UART_RxCmd = 0x1010d9f5;
    UART_Writable = 0x1010da09;
    UART_Readable = 0x1010da11;
    UART_CharPut = 0x1010da19;
    UART_CharGet = 0x1010da1d;
    UART_ReceiveData = 0x1010da25;
    UART_SendData = 0x1010da4d;
    UART_ReceiveDataTO = 0x1010da75;
    UART_SendDataTO = 0x1010dab5;
    UART_RxByteCntClear = 0x1010daf5;
    UART_RxByteCntGet = 0x1010db01;
    UART_BreakCtl = 0x1010db09;
    UART_ClearRxFifo = 0x1010db1d;
    UART_Init = 0x1010db3d;
    UART_ClearTxFifo = 0x1010dbe5;
    UART_INTConfig = 0x1010dbf1;
    UART_IntStatus = 0x1010dc01;
    UART_ModemStatusGet = 0x1010dc05;
    UART_LineStatusGet = 0x1010dc09;
    UART_WaitBusy = 0x1010dc0d;
    rtl_crypto_aes_cbc_init = 0x1010dc31;
    rtl_crypto_aes_cbc_encrypt = 0x1010dc81;
    rtl_crypto_aes_cbc_decrypt = 0x1010dccd;
    rtl_crypto_aes_ecb_init = 0x1010dd19;
    rtl_crypto_aes_ecb_encrypt = 0x1010dd69;
    rtl_crypto_aes_ecb_decrypt = 0x1010dda1;
    rtl_crypto_aes_ctr_init = 0x1010ddd9;
    rtl_crypto_aes_ctr_encrypt = 0x1010de29;
    rtl_crypto_aes_ctr_decrypt = 0x1010de6d;
    rtl_crypto_aes_cfb_init = 0x1010deb1;
    rtl_crypto_aes_cfb_encrypt = 0x1010df01;
    rtl_crypto_aes_cfb_decrypt = 0x1010df45;
    rtl_crypto_aes_ofb_init = 0x1010df89;
    rtl_crypto_aes_ofb_encrypt = 0x1010dfdd;
    rtl_crypto_aes_ofb_decrypt = 0x1010e021;
    rtl_crypto_aes_gcm_init = 0x1010e065;
    rtl_crypto_aes_gcm_encrypt = 0x1010e0b9;
    rtl_crypto_aes_gcm_decrypt = 0x1010e131;
    BOOT_ROM_SignatureCheck = 0x1010e1a9;
    BOOT_ROM_FromFlash = 0x1010e281;
    BOOT_ROM_InitDebugFlg = 0x1010e38d;
    BOOT_ROM_ResetVsr = 0x1010e3a9;
    EXT32K_Cmd = 0x1010e4c9;
    XTAL_ClkGet = 0x1010e4e9;
    CPU_ClkSet = 0x1010e501;
    CPU_ClkGet = 0x1010e515;
    CRYPTO_MemDump = 0x1010e539;
    CRYPTO_RegDump = 0x1010e601;
    CRYPTO_CleanCmdOk = 0x1010e7c1;
    CRYPTO_ClearAllINT = 0x1010e7f9;
    CRYPTO_Reset = 0x1010e829;
    CRYPTO_SetSecurityModeAD = 0x1010e86d;
    CRYPTO_Init = 0x1010ea49;
    CRYPTO_ProcessAD = 0x1010ea6d;
    CRYPTO_SendSeqBuf = 0x1010f681;
    CRYPTO_CipherInit = 0x1010f799;
    CRYPTO_CipherEncryptAD = 0x1010f7b9;
    CRYPTO_CipherDecryptAD = 0x1010f7e9;
    rtl_crypto_3des_cbc_init = 0x1010f819;
    rtl_crypto_3des_cbc_encrypt = 0x1010f869;
    rtl_crypto_3des_cbc_decrypt = 0x1010f8b5;
    rtl_crypto_3des_ecb_init = 0x1010f901;
    rtl_crypto_3des_ecb_encrypt = 0x1010f951;
    rtl_crypto_3des_ecb_decrypt = 0x1010f989;
    rtl_crypto_3des_cfb_init = 0x1010f9c1;
    rtl_crypto_3des_cfb_encrypt = 0x1010fa11;
    rtl_crypto_3des_cfb_decrypt = 0x1010fa49;
    rtl_crypto_3des_ofb_init = 0x1010fa81;
    rtl_crypto_3des_ofb_encrypt = 0x1010fad1;
    rtl_crypto_3des_ofb_decrypt = 0x1010fb09;
    rtl_crypto_3des_ctr_init = 0x1010fb41;
    rtl_crypto_3des_ctr_encrypt = 0x1010fb95;
    rtl_crypto_3des_ctr_decrypt = 0x1010fbcd;
    rtl_crypto_des_cbc_init = 0x1010fc05;
    rtl_crypto_des_cbc_encrypt = 0x1010fc59;
    rtl_crypto_des_cbc_decrypt = 0x1010fcb5;
    rtl_crypto_des_ecb_init = 0x1010fd11;
    rtl_crypto_des_ecb_encrypt = 0x1010fd65;
    rtl_crypto_des_ecb_decrypt = 0x1010fd9d;
    rtl_crypto_des_cfb_init = 0x1010fdd5;
    rtl_crypto_des_cfb_encrypt = 0x1010fe29;
    rtl_crypto_des_cfb_decrypt = 0x1010fe61;
    rtl_crypto_des_ofb_init = 0x1010fe99;
    rtl_crypto_des_ofb_encrypt = 0x1010feed;
    rtl_crypto_des_ofb_decrypt = 0x1010ff25;
    rtl_crypto_des_ctr_init = 0x1010ff5d;
    rtl_crypto_des_ctr_encrypt = 0x1010ffb1;
    rtl_crypto_des_ctr_decrypt = 0x1010ffe9;
    clear_ns_rom_bss = 0x10110021;
    RCC_PeriphClockCmd = 0x10110039;
    RCC_PeriphClockSource_RTC = 0x101100d1;
    RCC_PeriphClockSource_I2C = 0x1011011d;
    RCC_PeriphClockSource_QDEC = 0x1011013d;
    RCC_PeriphClockSource_UART = 0x1011015d;
    SYSCFG_GetChipInfo = 0x101101d1;
    INT_HardFault = 0x101101dd;
    INT_MemManage = 0x101101fd;
    INT_BusFault = 0x1011021d;
    INT_UsageFault = 0x1011023d;
    INT_SecureFault = 0x1011025d;
    INT_HardFault_C = 0x1011027d;
    INT_NMI = 0x1011064d;
    irq_table_init = 0x10110795;
    //irq_enable = 0x101109d1;
    //irq_disable = 0x101109ed;
    //irq_set_priority = 0x10110a11;
    //irq_get_priority = 0x10110a3d;
    //irq_set_pending = 0x10110a65;
    //irq_get_pending = 0x10110a81;
    //irq_clear_pending = 0x10110aa5;
    //irq_register = 0x10110ac1;
    //irq_unregister = 0x10110b0d;
    _char2num = 0x10110b2d;
    _2char2dec = 0x10110b5d;
    _2char2hex = 0x10110bd1;
    _memchr = 0x10110c39;
    _memcmp = 0x10110cc9;
    _memcpy = 0x10110d2d;
    _memmove = 0x10110dd9;
    _memset = 0x10110ea1;
    _vsscanf = 0x10110ffd;
    _sscanf = 0x101115c1;
    _stratoi = 0x101115e1;
    _strcat = 0x10111635;
    _strchr = 0x10111675;
    _strcmp = 0x10111745;
    _strcpy = 0x101117b9;
    _stricmp = 0x10111805;
    _strlen = 0x10111839;
    _strncat = 0x1011189d;
    _strncmp = 0x101118f9;
    _strncpy = 0x1011199d;
    _strnlen = 0x10111a05;
    _strpbrk = 0x10111a39;
    _strsep = 0x10111a65;
    _strstr = 0x10111d25;
    _strtoull = 0x10111f3d;
    _strtoll = 0x10111ffd;
    _strtok = 0x1011201d;
    __strtok_r = 0x10112029;
    _strtok_r = 0x1011208d;
    _strtol_r = 0x10112095;
    _strtol = 0x101121b1;
    _strtoul_r = 0x101121b5;
    _strtoul = 0x101122e9;
    _strupr = 0x101122ed;
    CRYPTO_chacha_20 = 0x10112309;
    rom_ed25519_gen_keypair = 0x101125c5;
    rom_ed25519_gen_signature = 0x101125c9;
    rom_ed25519_verify_signature = 0x101125df;
    rom_ed25519_ge_double_scalarmult_vartime = 0x10113e89;
    rom_ed25519_ge_frombytes_negate_vartime = 0x10114195;
    rom_ed25519_ge_p3_tobytes = 0x10114695;
    rom_ed25519_ge_scalarmult_base = 0x101146df;
    rom_ed25519_ge_tobytes = 0x10114807;
    rom_ed25519_crypto_sign_seed_keypair = 0x10114851;
    rom_ed25519_crypto_sign_verify_detached = 0x101148a9;
    rom_ed25519_sc_muladd = 0x10114ad5;
    rom_ed25519_sc_reduce = 0x1011b265;
    rom_ed25519_crypto_sign_detached = 0x1011c6dd;
    CRYPTO_poly1305_init = 0x1011ca99;
    CRYPTO_poly1305_update = 0x1011cb31;
    CRYPTO_poly1305_finish = 0x1011cba7;
    rom_sha512_starts = 0x1011cd4d;
    rom_sha512_update = 0x1011cd51;
    rom_sha512_finish = 0x1011cd55;
    rom_sha512 = 0x1011cd59;
    rom_sha512_hmac_starts = 0x1011cd5d;
    rom_sha512_hmac_update = 0x1011cdf1;
    rom_sha512_hmac_finish = 0x1011cdf5;
    rom_sha512_hmac_reset = 0x1011ce49;
    rom_sha512_hmac = 0x1011ce65;
    rom_sha512_hkdf = 0x1011cea1;
    curve25519_donna = 0x1011dce5;
    rtl_aes_init = 0x1011e569;
    rtl_aes_free = 0x1011e579;
    rtl_aes_setkey_enc = 0x1011e58d;
    rtl_aes_setkey_dec = 0x1011e7a5;
    rtl_aes_encrypt = 0x1011e8c1;
    rtl_aes_decrypt = 0x1011ecf9;
    rtl_aes_crypt_ecb = 0x1011f145;
    rtl_aes_crypt_cbc = 0x1011f1c9;
    rtl_aes_crypt_cfb128 = 0x1011f3d5;
    rtl_aes_crypt_cfb8 = 0x1011f44b;
    rtl_aes_crypt_ctr = 0x1011f4b1;
    rtl_arc4_init = 0x1011f515;
    rtl_arc4_free = 0x1011f525;
    rtl_arc4_setup = 0x1011f539;
    rtl_arc4_crypt = 0x1011f57f;
    rtl_asn1_get_len = 0x1011f5c5;
    rtl_asn1_get_tag = 0x1011f661;
    rtl_asn1_get_bool = 0x1011f689;
    rtl_asn1_get_int = 0x1011f6b9;
    rtl_asn1_get_mpi = 0x1011f6ff;
    rtl_asn1_get_bitstring = 0x1011f725;
    rtl_asn1_get_bitstring_null = 0x1011f76d;
    rtl_asn1_get_sequence_of = 0x1011f795;
    rtl_asn1_get_alg = 0x1011f81d;
    rtl_asn1_get_alg_null = 0x1011f8a9;
    rtl_asn1_free_named_data = 0x1011f8ed;
    rtl_asn1_free_named_data_list = 0x1011f91d;
    rtl_asn1_find_named_data = 0x1011f941;
    rtl_asn1_write_len = 0x1011f96d;
    rtl_asn1_write_tag = 0x1011fa55;
    rtl_asn1_write_raw_buffer = 0x1011fa71;
    rtl_asn1_write_mpi = 0x1011faa1;
    rtl_asn1_write_null = 0x1011fb13;
    rtl_asn1_write_oid = 0x1011fb39;
    rtl_asn1_write_algorithm_identifier = 0x1011fb6d;
    rtl_asn1_write_bool = 0x1011fbbd;
    rtl_asn1_write_int = 0x1011fbff;
    rtl_asn1_write_printable_string = 0x1011fc61;
    rtl_asn1_write_ia5_string = 0x1011fc95;
    rtl_asn1_write_bitstring = 0x1011fcc9;
    rtl_asn1_write_octet_string = 0x1011fd3d;
    rtl_asn1_store_named_data = 0x1011fd71;
    rtl_base64_encode = 0x1011fe29;
    rtl_base64_decode = 0x1011ff2d;
    rtl_mpi_init = 0x10120b19;
    rtl_mpi_free = 0x10120b27;
    rtl_mpi_grow = 0x10120b5d;
    rtl_mpi_shrink = 0x10120bc1;
    rtl_mpi_copy = 0x10120c41;
    rtl_mpi_swap = 0x10120c9d;
    rtl_mpi_safe_cond_assign = 0x10120cc5;
    rtl_mpi_safe_cond_swap = 0x10120d31;
    rtl_mpi_lset = 0x10120db3;
    rtl_mpi_get_bit = 0x10120df1;
    rtl_mpi_set_bit = 0x10120e11;
    rtl_mpi_lsb = 0x10120e61;
    rtl_mpi_bitlen = 0x10120e93;
    rtl_mpi_size = 0x10120ed3;
    rtl_mpi_read_binary = 0x10120edf;
    rtl_mpi_write_binary = 0x10120f47;
    rtl_mpi_shift_l = 0x10120f91;
    rtl_mpi_shift_r = 0x1012102d;
    rtl_mpi_cmp_abs = 0x101210ab;
    rtl_mpi_cmp_mpi = 0x101211ed;
    rtl_mpi_cmp_int = 0x10121277;
    rtl_mpi_add_abs = 0x101212a3;
    rtl_mpi_sub_abs = 0x10121357;
    rtl_mpi_add_mpi = 0x101213d5;
    rtl_mpi_sub_mpi = 0x10121417;
    rtl_mpi_add_int = 0x1012145b;
    rtl_mpi_sub_int = 0x10121487;
    rtl_mpi_mul_mpi = 0x101214b3;
    rtl_mpi_mul_int = 0x1012158f;
    rtl_mpi_read_string = 0x101215a9;
    rtl_mpi_div_mpi = 0x101216c9;
    rtl_mpi_div_int = 0x10121aeb;
    rtl_mpi_mod_mpi = 0x10121b15;
    rtl_mpi_mod_int = 0x10121b75;
    rtl_mpi_write_string = 0x10121c15;
    rtl_mpi_exp_mod = 0x10121d6d;
    rtl_mpi_gcd = 0x101221a5;
    rtl_mpi_fill_random = 0x101222af;
    rtl_mpi_inv_mod = 0x101224f9;
    rtl_mpi_is_prime = 0x101227b5;
    rtl_mpi_gen_prime = 0x10122809;
    rtl_ctr_drbg_init = 0x10122ae9;
    rtl_ctr_drbg_free = 0x10122af9;
    rtl_ctr_drbg_set_prediction_resistance = 0x10122b17;
    rtl_ctr_drbg_set_entropy_len = 0x10122b1b;
    rtl_ctr_drbg_set_reseed_interval = 0x10122b1f;
    rtl_ctr_drbg_update = 0x10122b23;
    rtl_ctr_drbg_reseed = 0x10122b47;
    rtl_ctr_drbg_seed_entropy_len = 0x10122bc5;
    rtl_ctr_drbg_seed = 0x10122c19;
    rtl_ctr_drbg_random_with_add = 0x10122c2b;
    rtl_ctr_drbg_random = 0x10122cf1;
    rtl_des_init = 0x10122d11;
    rtl_des_free = 0x10122d1d;
    rtl_des3_init = 0x10122d25;
    rtl_des3_free = 0x10122d35;
    rtl_des_key_set_parity = 0x10122d3f;
    rtl_des_key_check_key_parity = 0x10122d59;
    rtl_des_key_check_weak = 0x10122d7d;
    rtl_des_setkey = 0x10122da9;
    rtl_des_setkey_enc = 0x101231bb;
    rtl_des_setkey_dec = 0x101231e5;
    rtl_des3_set2key_enc = 0x10123239;
    rtl_des3_set2key_dec = 0x1012327d;
    rtl_des3_set3key_enc = 0x101232c1;
    rtl_des3_set3key_dec = 0x101232fd;
    rtl_des_crypt_ecb = 0x10123339;
    rtl_des_crypt_cbc = 0x10123541;
    rtl_des3_crypt_ecb = 0x10123731;
    rtl_des3_crypt_cbc = 0x10123b81;
    rtl_dhm_init = 0x10123e01;
    rtl_dhm_read_params = 0x10123e0d;
    rtl_dhm_make_params = 0x10123e59;
    rtl_dhm_read_public = 0x10123f91;
    rtl_dhm_make_public = 0x10123fb5;
    rtl_dhm_calc_secret = 0x1012406d;
    rtl_dhm_free = 0x1012426d;
    rtl_dhm_parse_dhm = 0x101242cf;
    rtl_ecdh_gen_public = 0x101243c1;
    rtl_ecdh_compute_shared = 0x101243c5;
    rtl_ecdh_init = 0x10124425;
    rtl_ecdh_free = 0x10124435;
    rtl_ecdh_make_params = 0x1012447d;
    rtl_ecdh_read_params = 0x101244ed;
    rtl_ecdh_get_params = 0x10124515;
    rtl_ecdh_make_public = 0x10124561;
    rtl_ecdh_read_public = 0x101245b1;
    rtl_ecdh_calc_secret = 0x101245dd;
    rtl_ecdsa_sign = 0x10124693;
    rtl_ecdsa_sign_det = 0x10124815;
    rtl_ecdsa_verify = 0x101248bd;
    rtl_ecdsa_write_signature = 0x101249f9;
    rtl_ecdsa_write_signature_det = 0x10124a9d;
    rtl_ecdsa_read_signature = 0x10124abb;
    rtl_ecdsa_genkey = 0x10124b55;
    rtl_ecdsa_from_keypair = 0x10124b83;
    rtl_ecdsa_init = 0x10124bbb;
    rtl_ecdsa_free = 0x10124bbf;
    rtl_ecjpake_init = 0x10124ff5;
    rtl_ecjpake_free = 0x1012504f;
    rtl_ecjpake_setup = 0x101250a5;
    rtl_ecjpake_check = 0x101250e9;
    rtl_ecjpake_read_round_one = 0x10125109;
    rtl_ecjpake_write_round_one = 0x10125185;
    rtl_ecjpake_read_round_two = 0x101252ad;
    rtl_ecjpake_write_round_two = 0x10125365;
    rtl_ecjpake_derive_secret = 0x101254a1;
    rtl_ecp_curve_list = 0x10125de9;
    rtl_ecp_curve_info_from_grp_id = 0x10125df1;
    rtl_ecp_curve_info_from_tls_id = 0x10125e0d;
    rtl_ecp_curve_info_from_name = 0x10125e29;
    rtl_ecp_point_init = 0x10125e51;
    rtl_ecp_group_init = 0x10125e71;
    rtl_ecp_keypair_init = 0x10125e81;
    rtl_ecp_point_free = 0x10125ea1;
    rtl_ecp_group_free = 0x10125ec1;
    rtl_ecp_keypair_free = 0x10125f31;
    rtl_ecp_copy = 0x10125f51;
    rtl_ecp_group_copy = 0x10125f7d;
    rtl_ecp_set_zero = 0x10125f83;
    rtl_ecp_is_zero = 0x10126839;
    rtl_ecp_point_cmp = 0x1012684b;
    rtl_ecp_point_read_string = 0x1012687d;
    rtl_ecp_point_write_binary = 0x101268a9;
    rtl_ecp_point_read_binary = 0x1012694d;
    rtl_ecp_tls_read_point = 0x101269b9;
    rtl_ecp_tls_write_point = 0x101269e9;
    rtl_ecp_tls_read_group = 0x10126a19;
    rtl_ecp_tls_write_group = 0x10126a61;
    rtl_ecp_check_pubkey = 0x10126a99;
    rtl_ecp_check_privkey = 0x10126c2d;
    rtl_ecp_mul = 0x10126c9d;
    rtl_ecp_muladd = 0x1012726f;
    rtl_ecp_gen_keypair_base = 0x101272d9;
    rtl_ecp_gen_keypair = 0x101273d9;
    rtl_ecp_gen_key = 0x101273f1;
    rtl_ecp_check_pub_priv = 0x10127419;
    rtl_ecp_group_load = 0x10128519;
    rtl_hmac_drbg_init = 0x1012893d;
    rtl_hmac_drbg_update = 0x10128949;
    rtl_hmac_drbg_seed_buf = 0x101289e5;
    rtl_hmac_drbg_reseed = 0x10128a35;
    rtl_hmac_drbg_seed = 0x10128aad;
    rtl_hmac_drbg_set_prediction_resistance = 0x10128b1d;
    rtl_hmac_drbg_set_entropy_len = 0x10128b21;
    rtl_hmac_drbg_set_reseed_interval = 0x10128b25;
    rtl_hmac_drbg_random_with_add = 0x10128b29;
    rtl_hmac_drbg_random = 0x10128bdd;
    rtl_hmac_drbg_free = 0x10128bed;
    rtl_md_list = 0x10128c09;
    rtl_md_info_from_string = 0x10128c11;
    rtl_md_info_from_type = 0x10128ca9;
    rtl_md_init = 0x10128ced;
    rtl_md_free = 0x10128cf9;
    rtl_md_clone = 0x10128d45;
    rtl_md_setup = 0x10128d6d;
    rtl_md_init_ctx = 0x10128db5;
    rtl_md_starts = 0x10128dbb;
    rtl_md_update = 0x10128dd5;
    rtl_md_finish = 0x10128df1;
    rtl_md = 0x10128e0d;
    rtl_md_hmac_starts = 0x10128e29;
    rtl_md_hmac_update = 0x10128eed;
    rtl_md_hmac_finish = 0x10128f0d;
    rtl_md_hmac_reset = 0x10128f65;
    rtl_md_hmac = 0x10128f91;
    rtl_md_process = 0x10128fe5;
    rtl_md_get_size = 0x10129001;
    rtl_md_get_type = 0x10129009;
    rtl_md_get_name = 0x1012900f;
    rtl_md5_init = 0x1012917d;
    rtl_md5_free = 0x10129189;
    rtl_md5_clone = 0x1012919d;
    rtl_md5_starts = 0x101291a9;
    rtl_md5_process = 0x101291d5;
    rtl_md5_update = 0x101298dd;
    rtl_md5_finish = 0x101298e3;
    rtl_md5 = 0x10129995;
    rtl_oid_get_attr_short_name = 0x101299fd;
    rtl_oid_get_x509_ext_type = 0x10129a35;
    rtl_oid_get_extended_key_usage = 0x10129a6d;
    rtl_oid_get_sig_alg_desc = 0x10129aa5;
    rtl_oid_get_sig_alg = 0x10129abd;
    rtl_oid_get_oid_by_sig_alg = 0x10129adb;
    rtl_oid_get_pk_alg = 0x10129b09;
    rtl_oid_get_oid_by_pk_alg = 0x10129b41;
    rtl_oid_get_ec_grp = 0x10129b69;
    rtl_oid_get_oid_by_ec_grp = 0x10129ba1;
    rtl_oid_get_cipher_alg = 0x10129bc9;
    rtl_oid_get_md_alg = 0x10129c01;
    rtl_oid_get_oid_by_md = 0x10129c39;
    rtl_oid_get_pkcs12_pbe_alg = 0x10129c61;
    rtl_pem_init = 0x10129e5f;
    rtl_pem_read_buffer = 0x10129e6d;
    rtl_pem_free = 0x1012a161;
    rtl_pem_write_buffer = 0x1012a185;
    rtl_pk_init = 0x1012a279;
    rtl_pk_free = 0x1012a283;
    rtl_pk_info_from_type = 0x1012a2a5;
    rtl_pk_setup = 0x1012a2d9;
    rtl_pk_setup_rsa_alt = 0x1012a305;
    rtl_pk_can_do = 0x1012a351;
    rtl_pk_verify = 0x1012a361;
    rtl_pk_sign = 0x1012a3bd;
    rtl_pk_decrypt = 0x1012a425;
    rtl_pk_encrypt = 0x1012a451;
    rtl_pk_check_pair = 0x1012a47d;
    rtl_pk_get_bitlen = 0x1012a4bd;
    rtl_pk_verify_ext = 0x1012a4cd;
    rtl_pk_debug = 0x1012a585;
    rtl_pk_get_name = 0x1012a5a9;
    rtl_pk_get_type = 0x1012a5bd;
    rtl_pk_write_pubkey = 0x1012aa23;
    rtl_pk_write_pubkey_der = 0x1012aaad;
    rtl_pk_write_key_der = 0x1012ab7d;
    rtl_pk_write_pubkey_pem = 0x1012ad79;
    rtl_pk_write_key_pem = 0x1012adc1;
    rtl_rsa_init = 0x1012aecd;
    rtl_rsa_set_padding = 0x1012aeed;
    rtl_rsa_check_pubkey = 0x1012aef7;
    rtl_rsa_check_privkey = 0x1012af4d;
    rtl_rsa_check_pub_priv = 0x1012b169;
    rtl_rsa_public = 0x1012b1a1;
    rtl_rsa_private = 0x1012b20f;
    rtl_rsa_rsaes_oaep_encrypt = 0x1012b465;
    rtl_rsa_rsaes_pkcs1_v15_encrypt = 0x1012b58d;
    rtl_rsa_pkcs1_encrypt = 0x1012b675;
    rtl_rsa_rsaes_oaep_decrypt = 0x1012b6b5;
    rtl_rsa_rsaes_pkcs1_v15_decrypt = 0x1012b821;
    rtl_rsa_pkcs1_decrypt = 0x1012b92d;
    rtl_rsa_rsassa_pss_sign = 0x1012b975;
    rtl_rsa_rsassa_pkcs1_v15_sign = 0x1012badd;
    rtl_rsa_pkcs1_sign = 0x1012bc85;
    rtl_rsa_rsassa_pss_verify_ext = 0x1012bcc9;
    rtl_rsa_rsassa_pss_verify = 0x1012be75;
    rtl_rsa_rsassa_pkcs1_v15_verify = 0x1012bea7;
    rtl_rsa_pkcs1_verify = 0x1012c009;
    rtl_rsa_free = 0x1012c04d;
    rtl_rsa_gen_key = 0x1012c0bb;
    rtl_rsa_copy = 0x1012c261;
    rtl_sha1_init = 0x1012c365;
    rtl_sha1_free = 0x1012c371;
    rtl_sha1_clone = 0x1012c385;
    rtl_sha1_starts = 0x1012c391;
    rtl_sha1_process = 0x1012c3c5;
    rtl_sha1_update = 0x1012d391;
    rtl_sha1_finish = 0x1012d397;
    rtl_sha1 = 0x1012d45d;
    rtl_sha256_init = 0x1012d491;
    rtl_sha256_free = 0x1012d49d;
    rtl_sha256_clone = 0x1012d4b1;
    rtl_sha256_starts = 0x1012d4bd;
    rtl_sha256_process = 0x1012d55d;
    rtl_sha256_update = 0x1012dc89;
    rtl_sha256_finish = 0x1012dc8f;
    rtl_sha256 = 0x1012dd91;
    rtl_sha512_init = 0x1012ddc9;
    rtl_sha512_free = 0x1012ddd5;
    rtl_sha512_clone = 0x1012dde9;
    rtl_sha512_starts = 0x1012ddf5;
    rtl_sha512_process = 0x1012df29;
    rtl_sha512_update = 0x1012ec7d;
    rtl_sha512_finish = 0x1012ec83;
    rtl_sha512 = 0x1012eeb9;
    __rom_entry_ns_start__ = 0x101c0000;
    rom_sec_call_ns_entry = 0x101c0000;
    __rom_entry_ns_end__ = 0x101c0008;
    SPIC_CALIB_PATTERN = 0x101c0008;
    PORT_AB = 0x101c0024;
    armBitRevIndexTable1024 = 0x101c004c;
    twiddleCoef_1024 = 0x101c0e5c;
    rtl_sha512_info = 0x101ce344;
    rtl_sha384_info = 0x101ce374;
    rtl_sha256_info = 0x101ce3a4;
    rtl_sha224_info = 0x101ce3d4;
    rtl_sha1_info = 0x101ce404;
    rtl_md5_info = 0x101ce434;
    rtl_rsa_alt_info = 0x101cea78;
    rtl_ecdsa_info = 0x101ceaa8;
    rtl_eckeydh_info = 0x101cead8;
    rtl_eckey_info = 0x101ceb08;
    rtl_rsa_info = 0x101ceb38;
    __rom_bss_end_s__ = 0x200f9000;
}
