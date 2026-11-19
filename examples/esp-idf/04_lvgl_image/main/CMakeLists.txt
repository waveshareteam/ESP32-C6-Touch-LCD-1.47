if(CONFIG_LV_USE_LIBJPEG_TURBO OR CONFIG_LV_USE_LIBPNG OR CONFIG_LV_USE_LZ4)
    message(FATAL_ERROR "This project uses LVGL 8.4. Keep all LVGL 9 decoder compatibility options disabled.")
endif()

idf_component_register(SRCS "main.c" "image_1.c"
                    INCLUDE_DIRS ".")
